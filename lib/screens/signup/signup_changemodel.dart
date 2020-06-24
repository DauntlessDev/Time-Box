import 'dart:async';

import 'package:TimeTracker/services/auth.dart';
import 'package:TimeTracker/utils/input_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SignupChangeModel with ChangeNotifier, InputValidator {
  SignupChangeModel(
      {@required this.auth,
      this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.submitEnabled = false,
      this.isLoading = false});

  final AuthBase auth;
  String email;
  String password;
  String confirmPassword;
  bool submitEnabled;
  bool isLoading;

  void updateWith({
    String email,
    String password,
    String confirmPassword,
    bool submitEnabled,
    bool isLoading,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.confirmPassword = confirmPassword ?? this.confirmPassword;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitEnabled = submitEnabled ?? this.submitEnabled;
    notifyListeners();
  }

  void updatePassword(String password) {
    removeWarnings();
    updateWith(password: password);
    updateWith(
        submitEnabled: (this.email.isNotEmpty &&
            this.password.isNotEmpty &&
            this.confirmPassword.isNotEmpty));
  }

  void updateConfirmPassword(String confirmPassword) {
    removeWarnings();
    updateWith(confirmPassword: confirmPassword);
    updateWith(
        submitEnabled: (this.email.isNotEmpty &&
            this.password.isNotEmpty &&
            this.confirmPassword.isNotEmpty));
  }

  void updateEmail(String email) {
    removeWarnings();
    updateWith(email: email);
    updateWith(
        submitEnabled: (this.email.isNotEmpty &&
            this.password.isNotEmpty &&
            this.confirmPassword.isNotEmpty));
  }

  String checkPasswordField() {
    return checkPassword(
        passwordOne: this.password, passwordTwo: this.confirmPassword);
  }

  String checkConfirmPasswordField() {
    return checkPassword(
        passwordOne: this.confirmPassword, passwordTwo: this.password);
  }

  Future<void> createWithEmailAndPassword() async {
    removeWarnings();
    toggleSubmit();

    if (this.password == this.confirmPassword) {
      updateWith(isLoading: true);
      try {
        return await auth.createWithEmailAndPassword(
            email: this.email, password: this.password);
      } catch (e) {
        rethrow;
      } finally {
        submitFailed();
        updateWith(isLoading: false);
      }
    } else {
      passwordDoesNotMatch();
      submitFailed();

      throw PlatformException(
          code: 'Password error',
          message: 'Password does not match, try again.');
    }
  }
}
