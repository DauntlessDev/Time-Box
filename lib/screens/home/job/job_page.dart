import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/screens/home/job/edit_job_bottomsheet.dart';
import 'package:TimeTracker/screens/home/job/job_listtile.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';

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
    final database = Provider.of<Database>(context);

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
        onPressed: () {
          EditJobBottomSheet.show(context, database: database);
        },
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder(
      stream: database.jobsStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error has occured.'));
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final List<Job> jobs = snapshot.data;
        final List<JobListTile> children = jobs
            .map((job) => JobListTile(
                job: job,
                onTap: () => EditJobBottomSheet.show(context,
                    database: database, job: job)))
            .toList();
        return ListView(children: children);
      },
    );
  }
}
