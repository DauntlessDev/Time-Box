import 'package:TimeTracker/screens/home_page.dart';
import 'package:TimeTracker/screens/login_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static final id = 'LandingPage';

  LandingPage({@required this.auth});

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage(auth: auth);
            } else {
              return HomePage(auth: auth);
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
