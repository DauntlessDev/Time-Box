import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/input_textfield.dart';
import 'package:TimeTracker/components/platformexception_alertdialog.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/screens/signup/signup_changemodel.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static final id = 'SignupPage';

  SignupPage({@required this.model});
  final SignupChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<SignupChangeModel>(
      create: (context) => SignupChangeModel(auth: auth),
      child: Consumer<SignupChangeModel>(
        builder:
            (BuildContext context, SignupChangeModel model, Widget child) =>
                SignupPage(model: model),
      ),
    );
  }

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupChangeModel get model => widget.model;
  Future<void> _createWithEmailAndPassword() async {
    try {
      await model.createWithEmailAndPassword();

      Navigator.pop(context);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'Sign up', exception: e)
          .show(context);
    } catch (e) {
      print(e);
    }
  }

  FocusNode _passwordNode, _confirmPasswordNode;
  void _emailComplete() {
    Focus.of(context).requestFocus(_passwordNode);
  }

  void _passwordComplete() {
    Focus.of(context).requestFocus(_confirmPasswordNode);
  }

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);
    return Scaffold(
      backgroundColor: constants.accentColor,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: model.isLoading,
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
                              callback: model.updateEmail,
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
                              callback: model.updatePassword,
                              errorText: model.checkPasswordField(),
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
                              callback: model.updateConfirmPassword,
                              errorText: model.checkConfirmPasswordField(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomButton(
                        text: 'Create Account',
                        color: constants.mainColor,
                        textcolor: constants.whiteColor,
                        onPressed: model.submitEnabled
                            ? _createWithEmailAndPassword
                            : null,
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
