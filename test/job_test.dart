import 'package:TimeTracker/screens/home/models/job.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
    test('job with all properties', () {
      final job = Job.fromMap({
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abcd');
      expect(job, Job(name: 'Blogging', id: 'abcd', ratePerHour: 10));
    });

    test('job missing name', () {
      final job = Job.fromMap({
        'ratePerHour': 10,
      }, 'abcd');
      expect(job, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      final job = Job(name: 'Blogging', ratePerHour: 10, id: 'abcd');
      expect(
          job.toMap(), {'id': 'abcd', 'name': 'Blogging', 'ratePerHour': 10});
    });
  });
}
