import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/constants.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  static final id = 'SignupPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AppTitle(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
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
                          SizedBox(
                            height: 20,
                          ),
                          InputTextField(
                            text: 'Confirm Password',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      text: 'Create Account',
                      color: k_mainColor,
                      textcolor: k_whiteColor,
                      onPressed: () {
                        //TODO: Create new firebase account
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
    );
  }
}
