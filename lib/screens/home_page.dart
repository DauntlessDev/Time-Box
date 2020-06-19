import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final id = 'HomePage';

  HomePage({@required this.auth, @required this.onSignOut});
  final AuthBase auth;
  final Function(User) onSignOut;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut(null);
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
