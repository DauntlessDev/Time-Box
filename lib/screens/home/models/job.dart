import 'package:flutter/cupertino.dart';
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

    if (data['name'] == null) {
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

  @override
  String toString() {
    return 'id: $id, name: $name, ratePerHour: $ratePerHour';
  }

  @override
  int get hashCode => hashValues(id, name, ratePerHour);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Job otherJob = other;
    return id == otherJob.id &&
        name == otherJob.name &&
        ratePerHour == otherJob.ratePerHour;
  }
}
