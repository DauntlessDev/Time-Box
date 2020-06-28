import 'package:TimeTracker/screens/home/home_page.dart';
import 'package:TimeTracker/screens/login/login_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  static final id = 'LandingPage';

  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage.create(context);
            } else {
              return Provider<Database>(
                  create: (BuildContext context) =>
                      FirestoreDatabase(uid: user.uid),
                  child: HomePage());
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
