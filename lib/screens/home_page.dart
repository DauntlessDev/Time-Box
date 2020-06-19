import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final id = 'HomePage';

  HomePage({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: k_mainColor,
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Text(
              'Logout',
              style: k_whiteTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
