import 'package:firebase_database/firebase_database.dart';

class Post {
  String key;
  String text;
  String user;

  Post(this.key, this.text, this.user);

  Post.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key ?? "0",
        text = snapshot.value["text"],
        user = snapshot.value["uid"];

  toJson() {
    return {
      "text": text,
      "user": user,
    };
  }
}