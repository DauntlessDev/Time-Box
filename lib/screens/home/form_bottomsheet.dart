import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/input_textfield.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'models/job.dart';

class FormBottomSheet extends StatefulWidget {
  FormBottomSheet(this.callback);
  final Function callback;
  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  Function get callback => widget.callback;
  Future<void> _createJob(Job job) async {
    setState(() {
      isLoading = true;
    });
    await callback(job);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  String inputName = "";
  int inputRate = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Job Form',
                  style: TextStyle(
                    color: constants.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                InputTextField(
                  text: 'Name:',
                  inputAction: TextInputAction.next,
                  callback: (value) => inputName = value,
                ),
                SizedBox(height: 15),
                InputTextField(
                  text: 'Rate per hour:',
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.next,
                  callback: (value) => inputRate = int.parse(value),
                ),
                SizedBox(height: 45),
                CustomButton(
                  color: constants.mainColor,
                  onPressed: (!inputRate.isNegative && inputName.isNotEmpty)
                      ? () => _createJob(
                          Job(name: inputName, ratePerHour: inputRate))
                      : null,
                  text: 'Confirm',
                  textcolor: constants.accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
