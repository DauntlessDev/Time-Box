import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.text,
      @required this.color,
      @required this.textcolor,
      @required this.onPressed});
  final Function onPressed;
  final String text;
  final Color color;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(15),
        color: this.color,
        onPressed: this.onPressed,
        child: Text(
          this.text,
          style: TextStyle(
              color: this.textcolor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
