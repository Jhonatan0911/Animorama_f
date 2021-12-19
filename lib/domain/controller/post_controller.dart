import 'package:f_202110_firebase/domain/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class PostController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.reference();
  var posts = <Post>[].obs;

  //Método start para comenzar a escuchar la colección de documentos FlutterMessages,
  //que contiene el mensaje a enviar en los chats
  start() {
    posts.clear();
    databaseReference
        .child("posts")
        .onChildAdded
        .listen((_onEntryAdded));
    databaseReference
        .child("posts")
        .onChildChanged
        .listen((_onEntryChanged));
  }

  //Método onEntryChanged listener
  //para añadir al listado los mensajes que llegan de la db
   _onEntryChanged(Event event) {
    var oldEntry = posts.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    posts[posts.indexOf(oldEntry)] = Post.fromSnapshot(event.snapshot);
  }

  //Método stop para dejar de escuchar la colección
  stop() {
    databaseReference
        .child("posts")
        .onChildAdded
        .listen(_onEntryAdded)
        .cancel();
    databaseReference
        .child("posts")
        .onChildChanged
        .listen((_onEntryChanged))
        .cancel();
  }

  _onEntryAdded(Event event) {
    print("Something was added");
    posts.add(Post.fromSnapshot(event.snapshot));

  }

  //Método sendmsg para enviar un nuevo mensaje
  Future<void> sendMsg(String text) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";;

    try {
      databaseReference
          .child("posts")
          .push()
          .set({"text": text, "uid": uid, "email": email});
    } catch (error) {
      logError("Error enviando el mensaje $error");
      return Future.error(error);
    }
  }

  Future<void> updateMsg(Post post) async {
    logInfo('updateMsg with key ${post.key}');
    try {
      databaseReference
          .child("posts")
          .child(post.key)
          .set({'text': 'updated ' + post.text, 'uid': post.user});
    } catch (error) {
      logError("Error updating msg $error");
      return Future.error(error);
    }
  }

  Future<void> deleteMsg(Post post, int index) async {
    logInfo('deleteMsg with key ${post.key}');
    try {
      databaseReference
          .child("posts")
          .child(post.key)
          .remove()
          .then((value) => posts.removeAt(index));
    } catch (error) {
      logError("Error deleting msg $error");
      return Future.error(error);
    }
  }
}
