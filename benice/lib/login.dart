import 'package:flutter/material.dart';

Color _lightPurple = Colors.deepPurple[200];
Color _midPurple   = Colors.deepPurple[300];
Color _darkPurple  = Colors.deepPurple[400];

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    Widget buildProfile() {
      return new Expanded(
        child: new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Text("helooo")
        ),
      );
    }

    Widget buildGoals() {
      return new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_lightPurple, _darkPurple],
              )
          ),
          child: ,

      );
    }
    return new Scaffold(
        body: new Container(
            color: new Color(0xFFFCFCFC),
            padding: const EdgeInsets.all(12.0),
            child: new Column(
              children: <Widget>[
                buildProfile(),
                buildGoals()
              ],
            )
        )

    );
  }
}
