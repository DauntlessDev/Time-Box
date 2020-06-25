import 'package:TimeTracker/screens/home/models/job.dart';
import 'package:TimeTracker/services/api_path.dart';
import 'package:TimeTracker/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid});
  final String uid;
  final FirestoreService _service = FirestoreService.intance;

  Stream<List<Job>> jobsStream() => _service.collectionStream<Job>(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );

  Future<void> createJob(Job job) async =>
      _service.setData(path: APIPath.job(uid, 'job_abc'), data: job.toMap());
}
