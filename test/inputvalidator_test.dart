import 'package:TimeTracker/utils/input_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non empty string', () {
    final validator = InputValidator();
    expect(validator.isValid('test'), true);
  });

   test('empty string', () {
    final validator = InputValidator();
    expect(validator.isValid(''), false);
  });


  
   test('null string', () {
    final validator = InputValidator();
    expect(validator.isValid(null), false);
  });
}
