import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {@required this.text,
      @required this.callback,
      @required this.inputAction,
      this.errorText,
      this.obsecured = false,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.onEditingComplete});

  final String text;
  final String errorText;
  final bool obsecured;
  final Function callback;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Function onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.text,
          style: constants.greyTextStyle,
        ),
        TextField(
          onEditingComplete: this.onEditingComplete,
          focusNode: this.focusNode,
          textInputAction: this.inputAction,
          keyboardType: this.keyboardType,
          obscureText: this.obsecured,
          onChanged: this.callback,
          decoration: InputDecoration(errorText: this.errorText),
        ),
      ],
    );
  }
}
