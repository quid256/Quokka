import 'package:flutter/material.dart';
import 'login.dart';
import 'mainscreen.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Be Nice',
      initialRoute: '/login',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new MainPage(),
        '/login': (BuildContext context) => new LoginPage()
      },
    );
  }
}