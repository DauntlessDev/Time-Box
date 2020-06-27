import 'package:flutter/foundation.dart';

class Job extends ChangeNotifier {
  Job({@required this.name, @required this.ratePerHour, @required this.id});

  final String id;
  String name;
  int ratePerHour;

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];

    return Job(id: documentId, name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
