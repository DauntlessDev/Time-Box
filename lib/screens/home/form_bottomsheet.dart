import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/input_textfield.dart';
import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'models/job.dart';

class FormBottomSheet extends StatefulWidget {
  FormBottomSheet(this.database);
  final Database database;
  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  Database get database => widget.database;
  Future<void> _createJob(Job job) async {
    final jobs = await database.jobsStream().first;
    final List<String> allNames = jobs.map((job) => job.name).toList();

    if (allNames.contains(job.name)) {
      await PlatformAlertDialog(
        confirmText: 'OK',
        content: 'Please change job name.',
        title: 'Job name exists',
      ).show(context);
    } else {
      setState(() {
        isLoading = true;
      });
      await database.createJob(job);
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  String _inputName = "";
  String _inputRate = "";

  int _rate = -1;
  bool _validateRate() {
    if (_inputRate.isEmpty) {
      return false;
    } else {
      try {
        _rate = int.parse(_inputRate);
        return (!_rate.isNegative && !_rate.isNaN);
      } catch (e) {
        return false;
      }
    }
  }

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
                  inputAction: TextInputAction.done,
                  callback: (value) => _inputName = value,
                ),
                SizedBox(height: 15),
                InputTextField(
                  text: 'Rate per hour:',
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  inputAction: TextInputAction.done,
                  callback: (value) {
                    _inputRate = value;
                  },
                ),
                SizedBox(height: 45),
                CustomButton(
                  color: constants.mainColor,
                  onPressed: (_validateRate() && _inputName.isNotEmpty)
                      ? () =>
                          _createJob(Job(name: _inputName, ratePerHour: _rate))
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
