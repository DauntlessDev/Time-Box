import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({@required this.child, @required this.auth});
  final Widget child;
  final AuthBase auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
