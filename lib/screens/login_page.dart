import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/login_bg.png"),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '-timeBox-',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KaushanScript'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Username',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextField(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          color: Colors.deepPurple,
                          onPressed: () {},
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text('or Sign in with', style: TextStyle(fontSize: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage('images/gmail_icon.png'),
                              width: 30,
                              height: 30),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                              image: AssetImage('images/facebook_icon.png'),
                              width: 30,
                              height: 30),
                        ],
                      ),
                      Text('Don\'t have an account? Sign up!'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
