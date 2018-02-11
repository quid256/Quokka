import 'package:firebase_database/firebase_database.dart';


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
      "key": key,
      "score": score,
      "gmail": gmailaccount,
      "streak": streak
    };
  }
}

final userReference = FirebaseDatabase.instance.reference().child('users');