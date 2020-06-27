import 'package:TimeTracker/utils/constants.dart';
import 'package:TimeTracker/screens/home/job/job_page.dart';
import 'package:TimeTracker/screens/landing_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);

    return Constants(
      child: Provider<AuthBase>(
        create: (BuildContext context) => Auth(),
        child: MaterialApp(
          theme: ThemeData(
            accentColor: Colors.deepPurple,
          ),
          title: 'timeBox',
          initialRoute: LandingPage.id,
          routes: {
            LandingPage.id: (context) => LandingPage(),
            JobPage.id: (context) => JobPage(),
            // LoginPage.id: (context) => LoginPage(),
            // SignupPage.id: (context) => SignupPage(),
          },
        ),
      ),
    );
  }
}
