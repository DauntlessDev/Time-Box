import 'dart:async';

import 'package:TimeTracker/screens/login/login_model.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  LoginBloc({@required this.auth});
  final AuthBase auth;

  final _modelSubject = BehaviorSubject<LoginModel>.seeded(LoginModel());

  Stream<LoginModel> get loginStream => _modelSubject.stream;
  LoginModel get _model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  void updatePassword(String password) {
    updateWith(password: password);
    updateWith(
        submitEnabled: (_model.password.isNotEmpty && _model.email.isNotEmpty));
  }

  void updateEmail(String email) {
    updateWith(email: email);
    updateWith(
        submitEnabled: (_model.password.isNotEmpty && _model.email.isNotEmpty));
  }

  void updateWith({
    String email,
    String password,
    bool submitEnabled,
    bool isLoading,
  }) {
    _modelSubject.add(
      _model.copyWith(
        email: email,
        password: password,
        isLoading: isLoading,
        submitEnabled: (_model.password.isNotEmpty && _model.email.isNotEmpty),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    updateWith(isLoading: true);
    try {
      return await auth.signInWithEmailAndPassword(
          email: _model.email, password: _model.password);
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
