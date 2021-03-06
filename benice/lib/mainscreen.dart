import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Color _lightPurple = Colors.deepPurple[200];
Color _midPurple   = Colors.deepPurple[300];
Color _darkPurple  = Colors.deepPurple[400];

class Goal extends StatefulWidget {
  final String message;
  final onCompleted;

  Goal({Key key, this.message, this.onCompleted }) : super(key: key);

  @override
  _Goal createState() => new _Goal();

  // Random Goal Generation
  static Goal randomGoal({onCompleted}) {
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
    return new Goal(message: message, onCompleted: onCompleted);
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
      if (!isCompleted) {
        isCompleted = true;
        widget.onCompleted();
      }
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



class MainPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final isDebug = false;
  final User currentUser;
  

  MainPage({Key key, this.googleSignIn, this.currentUser}) : super(key: key);

  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {

  User currentUser;

  Goal goal1, goal2, goal3;

  @override
  void initState() {
    super.initState();

    goal1 = Goal.randomGoal(onCompleted: incrementScore);
    goal2 = Goal.randomGoal(onCompleted: incrementScore);
    goal3 = Goal.randomGoal(onCompleted: incrementScore);

    currentUser = widget.currentUser;
    userReference.child(widget.googleSignIn.currentUser.id).onValue.listen(_onUserChanged);

  }

  void _onUserChanged(Event e) {
    setState(() {
      print("------" + e.snapshot.value.toString());
      currentUser = new User.fromSnapshot(e.snapshot);      
    });
  }


  void incrementScore() {
    userReference.child(widget.googleSignIn.currentUser.id).set({
      "key": currentUser.key,
      "score": currentUser.score + 1,
      "gmailaccount": currentUser.gmailaccount,
      "streak": currentUser.streak
    });
  }

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
                    margin: const EdgeInsets.only(right: 16.0, bottom: 10.0),
                    child: new GestureDetector(
                      child: !widget.isDebug ?
                        new CircleAvatar2(
                          radius: 75.0,
                          backgroundImage:
                            new NetworkImage(widget.googleSignIn.currentUser.photoUrl)
                        ) : new Icon(
                          Icons.account_circle,
                          size: 200.0
                        )
                      )
                    
                    
                ),
                new Padding(
                  padding: new EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                    !widget.isDebug ? widget.googleSignIn.currentUser.displayName : "john doe",
                    style: new TextStyle(
                      color: _darkPurple,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Open Sans"
                    )
                  ),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      currentUser.score.toString(),
                      style: new TextStyle(
                        color: _midPurple,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
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
            goal1, goal2, goal3
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

// Alternative CircleAvatar w/ Fitted Image
class CircleAvatar2 extends StatelessWidget {
  /// Creates a circle that represents a user.
  const CircleAvatar2({
    Key key,
    this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundColor,
    this.radius: 20.0,
    this.fit: BoxFit.cover,
  })
      : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget. If the [CircleAvatar] is to have an image, use
  /// [backgroundImage] instead.
  final Widget child;

  /// The color with which to fill the circle. Changing the background
  /// color will cause the avatar to animate to the new color.
  ///
  /// If a background color is not specified, the theme's primary color is used.
  final Color backgroundColor;

  /// The default text color for text in the circle.
  ///
  /// Falls back to white if a background color is specified, or the primary
  /// text theme color otherwise.
  final Color foregroundColor;

  /// The background image of the circle. Changing the background
  /// image will cause the avatar to animate to the new image.
  ///
  /// If the [CircleAvatar] is to have the user's initials, use [child] instead.
  final ImageProvider backgroundImage;

  /// The size of the avatar. Changing the radius will cause the
  /// avatar to animate to the new size.
  ///
  /// Defaults to 20 logical pixels.
  final double radius;

  /// Avatar Image BoxFit.
  ///
  /// Defaults to cover.
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final ThemeData theme = Theme.of(context);
    TextStyle textStyle = theme.primaryTextTheme.title;
    if (foregroundColor != null) {
      textStyle = textStyle.copyWith(color: foregroundColor);
    } else if (backgroundColor != null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor)) {
        case Brightness.dark:
          textStyle = textStyle.copyWith(color: Colors.white);
          break;
        case Brightness.light:
          textStyle = textStyle.copyWith(color: Colors.black);
          break;
      }
    }
    return new AnimatedContainer(
      width: radius * 2.0,
      height: radius * 2.0,
      duration: kThemeChangeDuration,
      decoration: new BoxDecoration(
        color: backgroundColor ?? theme.primaryColor,
        image: backgroundImage != null
            ? new DecorationImage(
          image: backgroundImage,
          fit: fit,
        )
            : null,
        shape: BoxShape.circle,
      ),
      child: child != null
          ? new Center(
          child: new MediaQuery(
            // Need to reset the textScaleFactor here so that the
            // text doesn't escape the avatar when the textScaleFactor is large.
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: new DefaultTextStyle(
              style: textStyle.copyWith(color: foregroundColor),
              child: child,
            ),
          ))
          : null,
    );
  }
}
