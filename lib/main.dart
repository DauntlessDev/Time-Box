import 'package:TimeTracker/screens/home_page.dart';
import 'package:TimeTracker/screens/landing_page.dart';
import 'package:TimeTracker/screens/login_page.dart';
import 'package:TimeTracker/screens/signup_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    return Provider<AuthBase>(
      create: (BuildContext context) => Auth(),
      child: MaterialApp(
        title: 'timeBox',
        initialRoute: LandingPage.id,
        routes: {
          LandingPage.id: (context) => LandingPage(),
          HomePage.id: (context) => HomePage(),
          LoginPage.id: (context) => LoginPage(),
          SignupPage.id: (context) => SignupPage(),
        },
      ),
    );
  }
}
