import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/screens/signup_page.dart';
import 'package:flutter/material.dart';

/* This is the login page of the application 
** where the user will be if they decided to sign in,
** here it includes 3 main options of sign, firebase, 
** google and facebook. Else if has no account,
** they can create by clicking the no account text below 
*/
class LoginPage extends StatelessWidget {
  static final id = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        backgroundColor: k_accentColor,
        body: SafeArea(
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              text: 'Password',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomButton(
                        text: 'Login',
                        color: k_mainColor,
                        textcolor: k_whiteColor,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                      ),
                      Text('or Sign in with', style: TextStyle(fontSize: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //For clickable login icon for google and facebook
                          Image(
                              image: AssetImage('images/gmail_icon.png'),
                              width: 30,
                              height: 30),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                              image: AssetImage('images/facebook_icon.png'),
                              width: 30,
                              height: 30),
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
        ));
  }
}
