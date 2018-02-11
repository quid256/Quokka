import 'package:flutter/material.dart';
import 'login.dart';
import 'mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'db.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {

  final googleSignIn = new GoogleSignIn();
  final auth = FirebaseAuth.instance;
 

  @override
  _MyApp createState() => new _MyApp();
}

class _MyApp extends State<MyApp> {

  User currentUser;
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Be Nice',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/main': (BuildContext context) => new MainPage(
          googleSignIn: widget.googleSignIn,
          currentUser: currentUser
        ),
        '/': (BuildContext context) => new LoginPage(
          googleSignIn: widget.googleSignIn,
          auth: widget.auth,
          onSignedIn: (User usr) {
            if (currentUser == null) {
              currentUser = usr;
              Navigator.of(context).pushNamed('/main');
            }
          })
      },
    );
  }
}