import 'package:TimeTracker/screens/home_page.dart';
import 'package:TimeTracker/screens/login_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:TimeTracker/services/auth_provider.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static final id = 'LandingPage';

  @override
  Widget build(BuildContext context) {
    final AuthBase auth = AuthProvider.of(context);
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage();
            } else {
              return HomePage();
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
