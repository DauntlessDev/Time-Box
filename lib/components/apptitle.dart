import 'package:flutter/cupertino.dart';

import '../constants.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
    Text(
      '-timeBox-',
      style: TextStyle(
          color: k_mainColor,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          fontFamily: 'KaushanScript'),
    ),
    SizedBox(
      height: 20,
    ),
        ],
      );
  }
}
