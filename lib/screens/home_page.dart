import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/components/platformexception_alertdialog.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);
    final AuthBase auth = Provider.of<AuthBase>(context);

    Future<void> _signOut() async {
      try {
        Future<bool> signout = PlatformAlertDialog(
          confirmText: 'Confirm',
          cancelText: 'Cancel',
          content: 'Are you sure in loggin out the account?',
          title: 'Log-out',
        ).show(context);

        if (await signout) {
          await auth.signOut();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(title: 'Sign out', exception: e);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.mainColor,
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Text(
              'Logout',
              style: constants.whiteTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
