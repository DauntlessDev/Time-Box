import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/screens/login/login_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  static final id = 'StartPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
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
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomButton(
                    color: k_mainColor,
                    text: 'Sign In',
                    textcolor: k_whiteColor,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                  ),
                  CustomButton(
                    color: Colors.grey[600],
                    text: 'Later',
                    textcolor: k_blackColor,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    ));
  }
}
