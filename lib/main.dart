import 'package:TimeTracker/screens/login/login_page.dart';
import 'package:TimeTracker/screens/sign_up/signup_page.dart';
import 'package:TimeTracker/screens/start/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    return MaterialApp(
      title: 'timeBox',
      initialRoute: StartPage.id,
      routes: {
        StartPage.id: (context) => StartPage(), 
        LoginPage.id: (context) => LoginPage(),
        SignupPage.id: (context) => SignupPage(),
      },
    );
  }
}
