import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'db.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Google - Firebase Login


Future<Null> _ensureLoggedIn(GoogleSignIn googleSignIn, FirebaseAuth auth) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null)
    user = await googleSignIn.signInSilently();
  if (user == null) {
    await googleSignIn.signIn();
  }
  if (await auth.currentUser() == null) {                          //new
    GoogleSignInAuthentication credentials =                       //new
    await googleSignIn.currentUser.authentication;                 //new
    await auth.signInWithGoogle(                                   //new
      idToken: credentials.idToken,                                //new
      accessToken: credentials.accessToken,                        //new
    );                                                             //new
  }                                                               //new
}

Color _lightPurple = Colors.deepPurple[200];
Color _midPurple   = Colors.deepPurple[300];
Color _darkPurple  = Colors.deepPurple[400];



class LoginPage extends StatefulWidget {

  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;

  final onSignedIn;

  LoginPage({Key key, this.googleSignIn, this.auth, this.onSignedIn}) : super(key: key);


  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {


  void onLoginButtonPressed(BuildContext context) {
    _ensureLoggedIn(widget.googleSignIn, widget.auth)
    ..then((_) {
      User _currentUser;

      userReference.child(widget.googleSignIn.currentUser.id).onValue.listen((ev) {
        if (ev.snapshot.value == null) {
          _currentUser = new User(
            0,
            widget.googleSignIn.currentUser.email,
            0
          );

          userReference.child(widget.googleSignIn.currentUser.id).set(
            _currentUser.toJson()
          );
          
        } else {
          _currentUser = new User.fromSnapshot(ev.snapshot);
        }

        widget.onSignedIn(_currentUser);

      });
    })
    ..catchError(() {
      print("Unable to sign into google acct");
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget buildLoginButton() {
      return new GestureDetector(
        onTap: () => onLoginButtonPressed(context),
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
      );
    }

    Widget loginScreen() {
      return new Expanded(
        child: new Center(
          child: new Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image(
                  image: new AssetImage(
                    "images/Logo-01.png"
                  )
                ),
                // new Icon(
                //   Icons.account_circle,
                //   size: 350.0,
                //   color: Colors.white
                // ),
                buildLoginButton()
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