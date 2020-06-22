import 'package:flutter/material.dart';

class Constants extends InheritedWidget {
  static Constants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Constants>();

  Constants({@required this.child});
  final Widget child;

// Colors
  final Color mainColor = Colors.deepPurple;
  final Color accentColor = Colors.white;
  final Color whiteColor = Colors.white;
  final Color blackColor = Colors.black;

// TextStyles
  final TextStyle greyTextStyle = TextStyle(color: Colors.grey);
  final TextStyle whiteTextStyle = TextStyle(color: Colors.white);
  final TextStyle blackTextStyle = TextStyle(color: Colors.white);

  @override
  bool updateShouldNotify(Constants oldWidget) => false;
}
