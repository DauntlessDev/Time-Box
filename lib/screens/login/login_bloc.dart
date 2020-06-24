import 'dart:async';

import 'package:TimeTracker/screens/login/login_model.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/foundation.dart';

class LoginBloc {
  LoginBloc({@required this.auth});
  final AuthBase auth;

  final StreamController<LoginModel> _loginController =
      StreamController<LoginModel>();
  Stream<LoginModel> get loginStream => _loginController.stream;

  LoginModel _loginModel = LoginModel();

  void dispose() {
    _loginController.close();
  }

  void updatePassword(String password) {
    updateWith(password: password);
    updateWith(
        submitEnabled:
            (_loginModel.password.isNotEmpty && _loginModel.email.isNotEmpty));
  }

  void updateEmail(String email) {
    updateWith(email: email);
    updateWith(
        submitEnabled:
            (_loginModel.password.isNotEmpty && _loginModel.email.isNotEmpty));
  }

  void updateWith({
    String email,
    String password,
    bool submitEnabled,
    bool isLoading,
  }) {
    _loginModel = _loginModel.copyWith(
      email: email,
      password: password,
      isLoading: isLoading,
      submitEnabled:
          (_loginModel.password.isNotEmpty && _loginModel.email.isNotEmpty),
    );
    _loginController.add(_loginModel);
  }

  Future<void> signInWithEmailAndPassword() async {
    updateWith(isLoading: true);
    try {
      return await auth.signInWithEmailAndPassword(
          email: _loginModel.email, password: _loginModel.password);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      updateWith(isLoading: true);
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}