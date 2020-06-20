import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/screens/signup_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/* This is the login page of the application 
** where the user will be if they decided to sign in,
** here it includes 3 main options of sign, firebase, 
** google and facebook. Else if has no account,
** they can create by clicking the no account text below 
*/
class LoginPage extends StatefulWidget {
  static final id = 'LoginPage';

  LoginPage({@required this.auth});
  final AuthBase auth;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await widget.auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      setSpinner(true);
      await widget.auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  String username ="";
  String password ="";

  Future<void> _signInWithEmailAndPassword() async {
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        setSpinner(true);
        print(password);
        await widget.auth
            .signInWithEmailAndPassword(email: this.username, password: this.password);
      } catch (e) {
        print(e);
        setSpinner(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
                        AppTitle(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            //For inputting username and password
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
                                obsecured: true,
                                text: 'Password',
                                callback: (value) {
                                  password = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        CustomButton(
                          text: 'Login',
                          color: k_mainColor,
                          textcolor: k_whiteColor,
                          onPressed: _signInWithEmailAndPassword,
                        ),
                        CustomButton(
                          color: Colors.grey[400],
                          text: 'Login as Guest',
                          textcolor: k_blackColor,
                          onPressed: _signInAnonymously,
                        ),
                        Text('or Sign in with', style: TextStyle(fontSize: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //For clickable login icon for google and facebook
                            FlatButton(
                              onPressed: _signInWithGoogle,
                              child: Image(
                                  image: AssetImage('images/gmail_icon.png'),
                                  width: 30,
                                  height: 30),
                            ),
                            FlatButton(
                              onPressed: _signInWithFacebook,
                              child: Image(
                                  image: AssetImage('images/facebook_icon.png'),
                                  width: 30,
                                  height: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        //Create account text
                        FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignupPage.id);
                            },
                            child: Text('Don\'t have an account? Sign up!')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
