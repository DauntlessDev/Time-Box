import 'package:TimeTracker/constants.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.text,
          style: k_greyTextStyle,
        ),
        TextField(),
      ],
    );
  }
}
