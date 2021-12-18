import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}
class _PostsPageState extends State<PostsScreen> {
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