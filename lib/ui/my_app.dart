import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:f_202110_firebase/domain/controller/chat_controller.dart';
import 'package:f_202110_firebase/domain/controller/firestore_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //banner de modo debug
      title: 'Login usando Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          surface: Colors.purple,
          primary: Colors.purple,
          onPrimary: Colors.white,
          primaryVariant: Colors.grey,
          secondary: Colors.grey,
          secondaryVariant: Colors.grey,
          background: Colors.grey,
          onBackground: Colors.white,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.grey,
          onSurface: Colors.purple,
        ),
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error ${snapshot.error}");
            return Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(FirebaseController());
            Get.put(AuthenticationController());
            Get.put(ChatController());
            return FirebaseCentral();
          }

          return Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Algo salió mal")),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Cargando")),
    );
  }
}
