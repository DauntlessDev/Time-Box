import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/platform_alertdialog.dart';
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

  String _username = "";
  String _password = "";

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setSpinner(true);
      await widget.auth.signInWithEmailAndPassword(
          email: this._username, password: this._password);
    } catch (e) {
      PlatformAlertDialog(
        confirmText: 'OK',
        content: e.toString(),
        title: 'Sign-in Failed',
      ).show(context);

      setSpinner(false);
    }
  }

  FocusNode _passwordNode;
  void _emailComplete() {
    Focus.of(context).requestFocus(_passwordNode);
  }

  bool submitEnabled = false;
  void updateSubmitEnabled() {
    return setState(() {
      submitEnabled = (_username.isNotEmpty && _password.isNotEmpty);
    });
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
                                inputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,
                                onEditingComplete: _emailComplete,
                                callback: (value) {
                                  _username = value;
                                  updateSubmitEnabled();
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InputTextField(
                                obsecured: true,
                                text: 'Password',
                                focusNode: _passwordNode,
                                inputAction: TextInputAction.done,
                                onEditingComplete: _signInWithEmailAndPassword,
                                callback: (value) {
                                  _password = value;
                                  updateSubmitEnabled();
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
                          onPressed: submitEnabled
                              ? _signInWithEmailAndPassword
                              : null,
                        ),
                        CustomButton(
                          color: Colors.purple[300],
                          text: 'Login as Guest',
                          textcolor: k_whiteColor,
                          onPressed: _signInAnonymously,
                        ),
                        Text('or Sign in with', style: TextStyle(fontSize: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //For clickable login icon for google and facebook
                            IconButton(
                              assetLink: 'images/gmail_icon.png',
                              onPressed: _signInWithGoogle,
                            ),
                            IconButton(
                              assetLink: 'images/facebook_icon.png',
                              onPressed: _signInWithFacebook,
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

// for google and facebook icon login
class IconButton extends StatelessWidget {
  IconButton({@required this.onPressed, @required this.assetLink});

  final Function onPressed;
  final String assetLink;
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.minPositive,
      child: FlatButton(
        onPressed: this.onPressed,
        child: Image(image: AssetImage(this.assetLink), width: 30, height: 30),
      ),
    );
  }
}
