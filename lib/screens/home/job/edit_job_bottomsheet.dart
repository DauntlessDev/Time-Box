import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:TimeTracker/services/database.dart';
import 'package:TimeTracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/job.dart';

class EditJobBottomSheet extends StatefulWidget {
  EditJobBottomSheet({@required this.database, this.job});
  final Job job;
  final Database database;

  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EditJobBottomSheet(database: database, job: job),
    );
  }

  @override
  _EditJobBottomSheetState createState() => _EditJobBottomSheetState();
}

class _EditJobBottomSheetState extends State<EditJobBottomSheet> {
  String _inputName;
  int _inputRate;
  @override
  void initState() {
    if (widget.job != null) {
      _inputName = widget.job.name;
      _inputRate = widget.job.ratePerHour;
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      print(_inputName);
      print(_inputRate);
      return true;
    }
    return false;
  }

  bool isLoading = false;
  Database get database => widget.database;
  Future<void> _createJob() async {
    if (_validateAndSaveForm()) {
      final jobs = await database.jobsStream().first;
      final List<String> allNames = jobs.map((job) => job.name).toList();
      if (widget.job != null) {
        allNames.remove(widget.job.name);
      }
      if (allNames.contains(_inputName)) {
        await PlatformAlertDialog(
          confirmText: 'OK',
          content: 'Please change job name.',
          title: 'Job name exists',
        ).show(context);
      } else {
        final id = widget.job?.id ?? documentIdFromCurrentDate();
        final job = Job(id: id, name: _inputName, ratePerHour: _inputRate);
        if (job.ratePerHour.isNegative) {
          await PlatformAlertDialog(
            confirmText: 'OK',
            content: 'Please change the rate per hour to positive.',
            title: 'Rate can\'t be negative',
          ).show(context);
        } else {
          setState(() {
            isLoading = true;
          });
          await database.setJob(job);
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final constants = Constants.of(context);

    if (isLoading == true) {
      return Center(
          heightFactor: double.minPositive,
          widthFactor: double.minPositive,
          child: CircularProgressIndicator());
    }
    return Padding(
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
                widget.job == null ? 'Add Job' : "Edit Job",
                style: TextStyle(
                  color: constants.mainColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildForm(),
              SizedBox(height: 45),
              CustomButton(
                color: constants.mainColor,
                onPressed: () => _createJob(),
                text: 'Confirm',
                textcolor: constants.accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Name:'),
        initialValue: _inputName,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty.',
        textInputAction: TextInputAction.done,
        onSaved: (value) => _inputName = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour:'),
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        initialValue: _inputRate != null ? _inputRate.toString() : '',
        textInputAction: TextInputAction.done,
        onSaved: (value) => _inputRate = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
