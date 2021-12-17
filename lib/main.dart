import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart'; //en el archivo packages
import 'ui/my_app.dart';

void main() {
  // esta es la key(llave)
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(MyApp());
}
