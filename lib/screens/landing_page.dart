import 'package:TimeTracker/screens/home_page.dart';
import 'package:TimeTracker/screens/start_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  static final id = 'LandingPage';

  LandingPage({@required this.auth});
  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return StartPage(auth: widget.auth, onSignIn: _updateUser);
    }
    return HomePage(auth: widget.auth, onSignOut: _updateUser);
  }
}
