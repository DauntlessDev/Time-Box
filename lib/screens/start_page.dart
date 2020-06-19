import 'package:TimeTracker/components/apptitle.dart';
import 'package:TimeTracker/components/custombutton.dart';
import 'package:TimeTracker/components/purple_bg.dart';
import 'package:TimeTracker/constants.dart';
import 'package:TimeTracker/screens/login_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/* This is the launching page of the application 
** where the user can choose if sign in or later (go anonymous) 
*/
class StartPage extends StatefulWidget {
  static final id = 'StartPage';

  StartPage({@required this.auth, @required this.onSignIn});
  final AuthBase auth;
  final Function(User) onSignIn;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool showSpinner = false;
  
  Future<void> _signInAnonymously() async {
    setState(() {
      showSpinner = true;
    });
    try {
      User user = await widget.auth.signInAnonymously();
      widget.onSignIn(user);

      print(user.toString());
    } catch (e) {
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: k_accentColor,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              children: <Widget>[
                //Expanded container of backgroung picture with flex 1
                PurpleBackground(),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //App Title -timeBox- design
                        AppTitle(),
                        CustomButton(
                          color: k_mainColor,
                          text: 'Sign In',
                          textcolor: k_whiteColor,
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.id);
                          },
                        ),
                        CustomButton(
                          color: Colors.grey[600],
                          text: 'Later',
                          textcolor: k_blackColor,
                          onPressed: _signInAnonymously,
                        ),
                      ],
                    ),
                  ),
                ),
                //Adding space to push the two buttons up in the middle.
                Expanded(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
          ),
        ));
  }
}
