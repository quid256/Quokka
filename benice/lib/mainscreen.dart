import 'package:flutter/material.dart';

Color _lightPurple = Colors.deepPurple[200];
Color _midPurple   = Colors.deepPurple[300];
Color _darkPurple  = Colors.deepPurple[400];

class Goal extends StatefulWidget {
  final String message;
  Goal({Key key, this.message}) : super(key: key);

  @override
  _Goal createState() => new _Goal();
}

class _Goal extends State<Goal> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.only(
          topRight: new Radius.circular(50.0),
          bottomRight: new Radius.circular(50.0),
          bottomLeft: new Radius.circular(50.0)
        ),
        color: Colors.white
      ),
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.check_circle,
              color: _midPurple,
            ),
            iconSize: 60.0,
            onPressed: null,
          ),
          new Text(
            widget.message,
            style: new TextStyle(
              color: _midPurple,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              fontFamily: "Open Sans"
            )
          )
        ],
      )
    );
  }
}


class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {

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

    Widget buildDailyGoalsHeader() {
      return new Row(
        children: <Widget>[new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            color: Colors.white
          ),
          padding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
          margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: new Row(
            children: <Widget>[
              new Icon(Icons.bookmark, color: _midPurple, size: 30.0),
              new Text(
                " daily goals",
                style: new TextStyle(
                  color: _midPurple,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Open Sans"
                ),
              )
            ],
          )
        )],
      );
    }

    Widget buildGoals() {
      return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_lightPurple, _darkPurple],
          )
        ),
        child: new Column(
          children: <Widget>[
            buildDailyGoalsHeader(),
            new Goal(message: "Compliment one person"),
            new Goal(message: "High five your best friend"),
            new Goal(message: "Perform a jig")
          ],
        )
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
