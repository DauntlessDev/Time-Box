import 'package:flutter/material.dart';

class PurpleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_bg.png"), fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
