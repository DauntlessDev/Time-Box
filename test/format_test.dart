import 'package:TimeTracker/screens/home/job_entries/format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  group('hours', () {
    test('positive', () => expect(Format.hours(10), '10h'));
    test('negative', () => expect(Format.hours(-10), '0h'));
    test('zero', () => expect(Format.hours(0), '0h'));
    test('decimal', () => expect(Format.hours(10.5), '10.5h'));
  });

  group('date - GB locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-19-12',
        () => expect(Format.date(DateTime(2020, 12, 12)), '12 Dec 2020'));

    test('2020-11-11',
        () => expect(Format.date(DateTime(2020, 11, 11)), '11 Nov 2020'));
  });

  group('dayOfWeek - GB locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Wednesday',
        () => expect(Format.dayOfWeek(DateTime(2020, 7, 1)), 'Wed'));
    test('Friday', () => expect(Format.dayOfWeek(DateTime(2020, 7, 3)), 'Fri'));
  });

  group('currency - US locale', () {
    setUp(() {
      Intl.defaultLocale = 'en_US';
    });
    test('positive', () => expect(Format.currency(10), '\$10'));
    test('negative', () => expect(Format.currency(-10), '-\$10'));
    test('zero', () => expect(Format.currency(0), ''));
  });
}
