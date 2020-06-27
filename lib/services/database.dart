import 'package:TimeTracker/screens/home/models/job.dart';
import 'package:TimeTracker/services/api_path.dart';
import 'package:TimeTracker/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid});
  final String uid;
  final FirestoreService _service = FirestoreService.intance;

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream<Job>(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Future<void> deleteJob(Job job) =>
      _service.deleteData(path: APIPath.job(uid, job.id));

  @override
  Future<void> setJob(Job job) async =>
      _service.setData(path: APIPath.job(uid, job.id), data: job.toMap());
}
