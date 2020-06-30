import 'package:TimeTracker/components/avatar.dart';
import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelText: 'Cancel',
      confirmText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: constants.mainColor,
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: constants.whiteTextStyle,
            ),
          )
        ],
        bottom: PreferredSize(
            child: _buildUserInfo(user), preferredSize: Size.fromHeight(130)),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          radius: 50,
          photoUrl: user.photoUrl,
        ),
        SizedBox(
          height: 8,
        ),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
