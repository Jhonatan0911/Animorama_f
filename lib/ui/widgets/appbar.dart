import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_202110_firebase/domain/controller/theme_controller.dart';

class CustomAppBar extends AppBar {
  final Widget title;
  final BuildContext context;
  final ThemeController controller;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar({
    Key? key,
    required this.controller,
    required this.context,
    required this.title,
  }) : super(
          key: key,
          centerTitle: true,
          title: title,
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  controller.darkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
              onPressed: () => controller.darkMode = !controller.darkMode,
            ),
          ],
          
        );
}
