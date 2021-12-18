import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_202110_firebase/domain/controller/theme_controller.dart';
import 'package:f_202110_firebase/ui/pages/screens/posts_screen.dart';
import 'package:f_202110_firebase/ui/widgets/appbar.dart';

class PostPage extends StatelessWidget {
  final ThemeController controller = Get.find();
  PostPage({Key? key}) : super(key: key);

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: controller,
        title: const Text("Publicaciones"),
        context: context,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: PostsScreen(),
        ),
      ),
    );
  }
}