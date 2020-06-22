import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/input_textfield.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/services/constants.dart';
import 'package:TimeTracker/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static final id = 'SignupPage';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthBase auth;
  bool showSpinner = false;

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  String _username = "";
  String _password = "";
  String _confirmPassword = "";

  //create input validator for show error text when user submitted and made mistakes
  final _inputValidator = InputValidator();

  Future<void> _createWithEmailAndPassword() async {
    _inputValidator.removeWarnings();
    _inputValidator.toggleSubmit();

    if (_password == _confirmPassword) {
      try {
        setSpinner(true);

        await auth.createWithEmailAndPassword(
            email: _username, password: _confirmPassword);

        Navigator.pop(context);
      } catch (e) {
        print(e);

        _inputValidator.submitFailed();
        setSpinner(false);
      }
    } else {
      setState(() {
        _inputValidator.passwordDoesNotMatch();
        _inputValidator.submitFailed();
      });
    }
  }

  FocusNode _passwordNode, _confirmPasswordNode;
  void _emailComplete() {
    Focus.of(context).requestFocus(_passwordNode);
  }

  void _passwordComplete() {
    Focus.of(context).requestFocus(_confirmPasswordNode);
  }

  //Functions for input validations

  bool submitEnabled = false;
  void updateSubmitEnabled() {
    setState(() {
      submitEnabled = (_username.isNotEmpty &&
          _password.isNotEmpty &&
          _confirmPassword.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);
    auth = Provider.of<AuthBase>(context);

    return Scaffold(
      backgroundColor: constants.accentColor,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            children: [
              //Expanded container of backgroung picture with flex 1
              PurpleBackground(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //App Title -timeBox- design
                      AppTitle(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        //Inputfields for creating account
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InputTextField(
                              text: 'Username',
                              onEditingComplete: _emailComplete,
                              keyboardType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              callback: (value) {
                                _username = value;
                                updateSubmitEnabled();
                              },
                              errorText: _inputValidator.checkSigupFields(
                                  field: _username),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              obsecured: true,
                              focusNode: _passwordNode,
                              text: 'Password',
                              onEditingComplete: _passwordComplete,
                              inputAction: TextInputAction.next,
                              callback: (value) {
                                _password = value;
                                updateSubmitEnabled();
                              },
                              errorText: _inputValidator.checkPassword(
                                  passwordOne: _password,
                                  passwordTwo: _confirmPassword),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              obsecured: true,
                              focusNode: _confirmPasswordNode,
                              text: 'Confirm Password',
                              onEditingComplete: _createWithEmailAndPassword,
                              inputAction: TextInputAction.done,
                              callback: (value) {
                                _confirmPassword = value;
                                updateSubmitEnabled();
                              },
                              errorText: _inputValidator.checkPassword(
                                  passwordOne: _confirmPassword,
                                  passwordTwo: _password),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomButton(
                        text: 'Create Account',
                        color: constants.mainColor,
                        textcolor: constants.whiteColor,
                        onPressed:
                            submitEnabled ? _createWithEmailAndPassword : null,
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Already have an account? Sign in!')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
