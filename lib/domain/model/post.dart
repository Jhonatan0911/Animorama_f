import 'package:firebase_database/firebase_database.dart';

class Post {
  String key;
  String text;
  String user;
  String email;

  Post(this.key, this.text, this.user, this.email);

  Post.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key ?? "0",
        text = snapshot.value["text"],
        user = snapshot.value["uid"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "text": text,
      "user": user,
      "email": email
    };
  }
}