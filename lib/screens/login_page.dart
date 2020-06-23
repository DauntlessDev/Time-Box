import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/input_textfield.dart';
import 'package:TimeTracker/components/platformexception_alertdialog.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/services/constants.dart';
import 'package:TimeTracker/screens/signup_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final id = 'LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBase auth;

  bool showSpinner = false;

  void setSpinner(bool state) {
    setState(() {
      showSpinner = state;
    });
  }

  void showPlatformExceptionAlertDialog(Exception e) {
    PlatformExceptionAlertDialog(title: 'Sign in', exception: e).show(context);
  }

  Future<void> _signInWithGoogle() async {
    try {
      setSpinner(true);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      showPlatformExceptionAlertDialog(e);
    } catch (e) {
      print(e.toString());
    } finally {
      setSpinner(false);
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      setSpinner(true);
      await auth.signInWithFacebook();
    } on PlatformException catch (e) {
      showPlatformExceptionAlertDialog(e);
    } catch (e) {
      print(e.toString());
    } finally {
      setSpinner(false);
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      setSpinner(true);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      showPlatformExceptionAlertDialog(e);
    } catch (e) {
      print(e);
    } finally {
      setSpinner(false);
    }
  }

  String _username = "";
  String _password = "";

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setSpinner(true);
      await auth.signInWithEmailAndPassword(
          email: _username, password: _password);
    } on PlatformException catch (e) {
      showPlatformExceptionAlertDialog(e);
    } catch (e) {
      print(e);
    } finally {
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
    final constants = Constants.of(context);
    auth = Provider.of<AuthBase>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: constants.accentColor,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Column(
              children: [
                //Expanded container of background picture with flex 1
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
                          color: constants.mainColor,
                          textcolor: constants.whiteColor,
                          onPressed: submitEnabled
                              ? _signInWithEmailAndPassword
                              : null,
                        ),
                        CustomButton(
                          color: Colors.purple[300],
                          text: 'Login as Guest',
                          textcolor: constants.whiteColor,
                          onPressed: _signInAnonymously,
                        ),
                        Text('or Sign in with', style: TextStyle(fontSize: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
