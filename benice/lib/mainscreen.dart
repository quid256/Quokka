import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';


Color _lightPurple = Colors.deepPurple[200];
Color _midPurple   = Colors.deepPurple[300];
Color _darkPurple  = Colors.deepPurple[400];

class Goal extends StatefulWidget {
  final String message;
  Goal({Key key, this.message }) : super(key: key);

  @override
  _Goal createState() => new _Goal();

  // Random Goal Generation
  static Goal randomGoal() {
    var r = new Random();
    var randInt = r.nextInt(1); // Change to 1 if shorter phrases desired.
    var message;
    if (randInt < 1) {
      message = _getAction(r) + " " + _getPerson(r) + ".";
    } else if (randInt < 2) {
      message = _getPhraseStart(r) + " " + _getPhraseEnd(r) + ".";
    } else if (randInt < 3) {
      message = _getNounStart(r) + " " + _getNounEnd(r) + ".";
    } else if (randInt < 4) {
      message = _getGerundStart(r) + " " + _getGerundEnd(r) + ".";
    } else {
      message = "ERROR: Contact a system administrator.";
    }
    return new Goal(message: message);
  }

  // Hardcoded Goal Values
  static String _getGerundStart(Random r) {
    var gs = [
      "Do something kind by",
      "Take a break from the usual by",
      "Brighten someone's day by"
    ];
    return gs[r.nextInt(gs.length)];
  }
  static String _getGerundEnd(Random r) {
    var ge = [
      "saying hello to a stranger",
      "treating yourself",
      "hugging someone important",
      "starting a meaningful conversation",
      "encouraging a friend in need"
    ];
    return ge[r.nextInt(ge.length)];
  }

  static String _getPhraseStart(Random r) {
    var ps = [
      "Tell a stranger",
      "Tell a friend",
      "Brighten someone's day by telling them"
    ];
    return ps[r.nextInt(ps.length)];
  }
  static String _getPhraseEnd(Random r) {
    var pe = [
      "you love them",
      "they look nice",
      "you're happy to see them"
    ];
    return pe[r.nextInt(pe.length)];
  }

  static String _getNounStart(Random r) {
    var ns = [
      "Brighten someone's day by giving them",
      "Make someone smile by sharing",
      "Give a friend",
      "Give a stranger"
    ];
    return ns[r.nextInt(ns.length)];
  }
  
  static String _getNounEnd(Random r) {
    var ne = [
      "a compliment",
      "a nice memory",
      "something you made",
      "something that would make you smile"
    ];
    return ne[r.nextInt(ne.length)];
  }

  static String _getAction(Random r) {
    var v = [
      "Compliment",
      "High-five",
      "Laugh with",
      "Encourage",
      "Joke with",
      "Smile at",
      "Talk with",
      "Listen to"
    ];
    return v[r.nextInt(v.length)];
  }
  
  static String _getPerson(Random r) {
    var p = [
      "a friend",
      "a loved one",
      "a stranger",
      "a family member",
      "your best friend",
      "an acquaintance"
    ];
    return p[r.nextInt(p.length)];
  }
}

class _Goal extends State<Goal> {

  bool isCompleted = false;  

  void completeGoal() {
    setState(() {
      isCompleted = ! isCompleted;
    });
  }

  


  @override
  Widget build(BuildContext context) {

    Color bgColor, accentColor;
    if (isCompleted) {
      bgColor = Colors.deepPurple[100];
      accentColor = Colors.white;
    } else {
      bgColor = Colors.white;
      accentColor = _midPurple;
    }


    return new GestureDetector(
      onTapDown: (tdd) => completeGoal(),
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
            topRight: new Radius.circular(50.0),
            bottomRight: new Radius.circular(50.0),
            bottomLeft: new Radius.circular(50.0)
          ),
          color: bgColor
        ),
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        child: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                isCompleted ? Icons.check_circle : Icons.fiber_manual_record,
                color: accentColor,
              ),
              iconSize: 60.0,
              onPressed: null,
            ),
            new Text(
              widget.message,
              style: new TextStyle(
                color: accentColor,
                fontSize: 20.0,
                fontWeight: isCompleted ? FontWeight.w400 : FontWeight.w300,
                fontFamily: "Open Sans"
              )
            )
          ],
        )
      )
    );
  }
}

class User {
  String key;
  int score;
  String gmailaccount;
  int streak;

  User(this.score, this.gmailaccount, this.streak);

  User.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      score = snapshot.value["score"].toInt(),
      streak = snapshot.value["streak"].toInt(),
      gmailaccount = snapshot.value["gmailaccount"];

  toJson() {
    return {
      "score": score,
      "gmail": gmailaccount,
      "streak": streak
    };
  }
}

class MainPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final userReference = FirebaseDatabase.instance.reference().child('users');

  MainPage({Key key, this.googleSignIn}) : super(key: key);

  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {

  _MainPage() {
    // widget.userReference.onChildAdded.listen(_onUserAdded);
    // widget.userReference.onChildChanged.listen(_onUserChanged);

  }

  // void _onUserAdded(Event e) {

  // }

  // void _onUserChanged(Event e) {

  // }

  @override
  Widget build(BuildContext context) {

    Widget buildProfile() {
      return new Expanded(
        child: new Center(
          child: new Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new GestureDetector(
                      onTap: () {
                        widget.userReference.push().set(new User(1285, "quidnovum@gmail.com", 85).toJson());
                      },
                      child: new CircleAvatar(
                        backgroundImage:
                        new NetworkImage(widget.googleSignIn.currentUser.photoUrl)
                      )
                    )
                    
                    
                ),
                new Padding(
                  padding: new EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                    widget.googleSignIn.currentUser.displayName,
                    style: new TextStyle(
                      color: _darkPurple,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Open Sans"
                    )
                  ),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      "1285|",
                      style: new TextStyle(
                        color: _midPurple,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Open Sans"
                      )
                    )
                  ],
                )
              ],
            )
          )
          
          
        )
      
      );
    }

    Widget buildDailyGoalsHeader() {
      return new Row(
        children: <Widget>[
          new Container(
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
          )
        ],
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
            Goal.randomGoal(),
            Goal.randomGoal(),
            Goal.randomGoal()
            // new Goal(message: "Compliment one person"),
            // new Goal(message: "High five your best friend"),
            // new Goal(message: "Perform a jig")
          ],
        )
      );
    }
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/Net3-01.png"),
            // colorFilter: new ColorFilter.mode(new Color(0xBBFFFFFF), BlendMode.srcOver)
          )
        ),
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
