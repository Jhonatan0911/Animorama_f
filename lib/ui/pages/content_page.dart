import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:f_202110_firebase/ui/pages/gps_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/chat_page.dart';
import '../widgets/firestore_page.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectIndex = 0;
  AuthenticationController authenticationController = Get.find();
  static List<Widget> _widgets = <Widget>[
    FireStorePage(),
    ChatPage(),
    GpsPage()
  ]; //páginas de navegación

  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Bienvenid@ ${authenticationController.userEmail()}"),
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              icon: Icon(Icons.pets),
              label: "Mascotas"),
          BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              icon: Icon(Icons.mail),
              label: "Mensajes"),
          BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              icon: Icon(Icons.place_outlined),
              label: "Ubicacion"),
          BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              icon: Icon(Icons.person),
              label: 'Mi cuenta'),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
