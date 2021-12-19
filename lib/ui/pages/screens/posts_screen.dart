import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:f_202110_firebase/domain/model/post.dart';
import 'package:f_202110_firebase/domain/controller/post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loggy/loggy.dart';
import 'package:f_202110_firebase/domain/controller/location.dart';



final databaseReference = FirebaseDatabase.instance.reference();

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}
class _PostsPageState extends State<PostsScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  final authController = Get.find<AuthenticationController>();
  AuthenticationController authenticationController = Get.find();
  PostController postController = Get.find();
  final locationController = Get.find<LocationController>();



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    postController.start();
  }

  @override
  void dispose() {
    postController.stop();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  Widget _post(Post element, int posicion, String uid) {
    logInfo('Current user? -> ${uid == element.user} msg -> ${element.text}');
    return Card(
      margin: EdgeInsets.all(4.0),
      color: Colors.grey[300],
      child: ListTile(
        onTap: () => postController.updateMsg(element),
        onLongPress: () => postController.deleteMsg(element, posicion),
        title: Text(
          element.text,
          textAlign: uid == element.user ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }
 
  Widget _list() {
    String uid = authenticationController.userUid();
    print('Current user $uid');
    return GetX<PostController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        itemCount: postController.posts.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = postController.posts[index];
          return _post(element, index, uid);
        },

      );
    });
  }
  
  Future<void> _sendMsg(String text) async {
    //FocusScope.of(context).requestFocus(FocusNode());
    logInfo("Calling _sendMsg with $text");
    await postController.sendMsg(text);
  }


  Widget _textInput() {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("CREAR PUBLICACIÓN"),
              subtitle: Text("${authenticationController.userEmail()}"),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0, bottom: 5.0),
              child: TextField (
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Post',
                ),
                onSubmitted: (value) {
                  Get.snackbar('Publicado exitosamente', '${_controller.text}');
                  _sendMsg(_controller.text);
                  _controller.clear();
                },
                controller: _controller,
              )
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('PUBLICAR UBICACION'),
                  onPressed: () {

                    _sendMsg("Hola, Esta es mi ubicación actual: https://www.google.es/maps?q=${locationController.location!.lat},${locationController.location!.long}");
                    Get.snackbar('Publicado exitosamente', 'Hola, Esta es mi ubicación actual: https://www.google.es/maps?q=${locationController.location!.lat},${locationController.location!.long}');
                    _controller.clear();
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('PUBLICAR'),
                  onPressed: () {
                    Get.snackbar('Publicado exitosamente', '${_controller.text}');
                    _sendMsg(_controller.text);
                    _controller.clear();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }



  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    return Container(
      child: Column(
        children: [Expanded(flex: 4, child: _list()), _textInput()],
      ),
    );
  }

}