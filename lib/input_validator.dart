//check if the user tried to submit but failed, if submitted, show error text

import 'package:flutter/foundation.dart';

class InputValidator {
  bool _submitted = false;
  bool _failed = false;
  bool _passwordDoesNotMatch = false;

  String checkPassword(
      {@required String passwordOne, @required String passwordTwo}) {
    return passwordOne.length < 6
        ? 'Password must be atleast 6 characters.'
        : !_submitted
            ? null
            : passwordOne.isEmpty
                ? 'Field can\'t be empty.'
                : _passwordDoesNotMatch ? 'Password does not match.' : null;
  }

  String checkSigupFields({@required field}) {
    return (_passwordDoesNotMatch
        ? null
        : _failed
            ? 'Invalid Email or Username already exists.'
            : !_submitted
                ? null
                : field.isEmpty ? 'Field can\'t be empty.' : null);
  }

  void passwordDoesNotMatch() {
    _passwordDoesNotMatch = true;
  }

  void submitFailed() {
    _failed = true;
  }

  void removeWarnings() {
    _failed = false;
    _passwordDoesNotMatch = false;
  }

  void toggleSubmit() {
    _submitted = true;
  }
}
