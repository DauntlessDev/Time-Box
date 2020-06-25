import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobPage extends StatelessWidget {
  static final id = 'HomePage';
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelText: 'Cancel',
      confirmText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.createJob({
      'name': 'Blogging',
      'ratePerHour': 10,
    });
  }

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }
}
