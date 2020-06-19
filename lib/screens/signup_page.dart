import 'package:TimeTracker/components/InputTextField.dart';
import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/constants.dart';
import 'package:flutter/material.dart';

/* This is the page of the application 
** for creating account, has very similar design 
** and widgets with the login page
*/
class SignupPage extends StatelessWidget {
  static final id = 'SignupPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //
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
