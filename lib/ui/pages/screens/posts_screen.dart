import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animorama',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Animorama Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  bool _selected = false;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
        Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/perfilperro.webp', height: 240, width: 240),
        Container(alignment: Alignment.topCenter,
          child: 
            Text(
              _selected ? "Luna02" : "Luna02",
              style: TextStyle(fontSize: 26, 
                               fontWeight: FontWeight.bold),
            ),
           ), 
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecondPage()));
                  },
                  child: const Text('Agregar publicación'))
            ]),
          ],
        ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar publicación')),
      body: Center(
          child: Column(
        children: [
          const Text('Agregar imagen'),
          TextFormField(keyboardType: TextInputType.multiline,maxLines:5
          )],
      ),
    ));
  }
}