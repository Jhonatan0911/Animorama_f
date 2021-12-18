import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:f_202110_firebase/domain/controller/chat_controller.dart';
import 'package:f_202110_firebase/domain/controller/firestore_controller.dart';
import 'package:f_202110_firebase/domain/managements/theme_management.dart';
import 'package:f_202110_firebase/domain/controller/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_central.dart';
import 'package:f_202110_firebase/ui/theme/theme.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Dependency injection: setting up state management
  late final ThemeController controller = Get.put(ThemeController());
  // Theme management
  late final ThemeManager manager = ThemeManager();
  bool isLoaded = false;

  Future<void> initializeTheme() async {
    controller.darkMode = await manager.storedTheme;
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    ever(controller.reactiveDarkMode, (bool isDarkMode) {
      manager.changeTheme(isDarkMode: isDarkMode);
    });
    initializeTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const CircularProgressIndicator()
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Login usando Firebase',
            theme: MyTheme.ligthTheme,
            darkTheme: MyTheme.darkTheme,
            themeMode: ThemeMode.system,
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
