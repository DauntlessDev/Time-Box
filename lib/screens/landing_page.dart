import 'package:TimeTracker/screens/login_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  static final id = 'LandingPage';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
