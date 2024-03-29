import 'package:TimeTracker/screens/home/models/job.dart';
import 'package:flutter/material.dart';

class JobListTile extends StatelessWidget {
  JobListTile({@required this.job, @required this.onTap});
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.assignment),
      title: Text(job.name),
      subtitle: Text('${job.ratePerHour}\$'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
