import 'package:flutter/material.dart';

class Goal extends StatefulWidget {
  Goal({Key key}) : super(key: key);

  @override
  _Goal createState() => new _Goal();
}

class _Goal extends State<Goal> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          elevation: 2.0,
          highlightElevation: 2.0,
          disabledElevation: 1.0,
          child: new Text("Button")
        ),
        new Text("Stufffff")
      ],
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Goal(),
            new Goal()
          ],
        )
      )
    );
    // return new Scaffold(
    //   body: new Center(
    //     child: new Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         new Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         new Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.display2,
    //         ),

    //       ],
    //     ),
    //   ),
    //   floatingActionButton: new FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: new Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
