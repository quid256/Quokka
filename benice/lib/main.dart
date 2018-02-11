import 'package:flutter/material.dart';
import 'login.dart';
import 'mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  final googleSignIn = new GoogleSignIn();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Be Nice',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new MainPage(googleSignIn: googleSignIn),
        '/login': (BuildContext context) => new LoginPage(googleSignIn: googleSignIn, auth: auth)
      },
    );
  }
}