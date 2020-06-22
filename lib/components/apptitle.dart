import 'package:TimeTracker/services/constants.dart';
import 'package:flutter/cupertino.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);

    return Column(
      children: <Widget>[
        Text(
          '-timeBox-',
          style: TextStyle(
              color: constants.mainColor,
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
