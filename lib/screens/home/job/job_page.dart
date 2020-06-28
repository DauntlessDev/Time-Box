import 'package:TimeTracker/components/platformexception_alertdialog.dart';
import 'package:TimeTracker/screens/home/job/edit_job_bottomsheet.dart';
import 'package:TimeTracker/screens/home/job/job_listtile.dart';
import 'package:TimeTracker/screens/home/job/listitem_builder.dart';
import 'package:TimeTracker/screens/home/job_entries/job_entries_page.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';

class JobPage extends StatelessWidget {
  static final id = 'HomePage';

  Future<void> _deleteJob(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'Delete error', exception: e)
          .show(context);
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
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
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            background: Container(
              color: Colors.blueGrey[100],
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete),
              ),
            ),
            onDismissed: (direction) => _deleteJob(context, job),
            key: Key('job-${job.id}'),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}
