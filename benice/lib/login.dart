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

    Widget loginScreen() {
      return new Expanded(
          child: new Center(
              child: new Container(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                         Icons.account_circle,
                         size: 350.0,
                         color: Colors.white
                      ),
                      new GestureDetector(
                      onTap: null,
                      child: new Container(
                          decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.white
                          ),
                          margin: new EdgeInsets.only(top: 50.0),
                          padding: const EdgeInsets.all(10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                "Sign in",
                                style: new TextStyle(
                                color: _midPurple,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Open Sans"
                                )
                              )
                             ],
                            )
                          )
                         )
      ]
      )
      )
      )
      );
        }


    return new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_lightPurple, _darkPurple],
                )
            ),
            child: new Column(
              children: <Widget>[
                loginScreen()
               ],
            )
        )
    );
  }
}