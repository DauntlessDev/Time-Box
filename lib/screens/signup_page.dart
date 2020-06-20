import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/* This is the page of the application 
** for creating account, has very similar design 
** and widgets with the login page
*/
class SignupPage extends StatefulWidget {
  static final id = 'SignupPage';

  SignupPage({@required this.auth});
  final AuthBase auth;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool showSpinner = false;

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  String username;
  String password;
  String confirmPassword;

  Future<void> _createWithEmailAndPassword() async {
    try {
      setSpinner(true);
      User user =  await widget.auth
          .createWithEmailAndPassword(email: username, password: password);

          print(user.toString());
    } catch (e) {
      print(e);
    }

    setSpinner(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: k_accentColor,
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
                              callback: (value) {
                                username = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              text: 'Password',
                              callback: (value) {
                                password = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              text: 'Confirm Password',
                              callback: (value) {
                                confirmPassword = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomButton(
                        text: 'Create Account',
                        color: k_mainColor,
                        textcolor: k_whiteColor,
                        onPressed: () async {
                          //
                          if (username.isNotEmpty &&
                              (password == confirmPassword)) {
                            await _createWithEmailAndPassword();
                          }
                          Navigator.pop(context);
                          
                        },
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
