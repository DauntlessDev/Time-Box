import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/screens/sign_up/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static final id = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: k_accentColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/login_bg.png"),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '-timeBox-',
                        style: TextStyle(
                            color: k_mainColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KaushanScript'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Username',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(),
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
