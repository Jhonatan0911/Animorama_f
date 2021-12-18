import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase/domain/model/record.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FirebaseController extends GetxController {
  var _records = <Record>[].obs;
  //implementa los getters necesarios para los datos y el stream
  final CollectionReference baby =
      FirebaseFirestore.instance.collection('baby');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('baby').snapshots();
  late StreamSubscription<Object?> streamSubscription;

  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Tomar nuevo item de fireStore');
      _records.clear();
      event.docs.forEach((element) {
        _records.add(Record.fromSnapshot(element));
      });
      print('Tiene ${_records.length}');
    });
  }

  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  List<Record> get entries => _records;

//Implementa el método para agregar datos en firestore
  addEntry(name) {
    baby
        .add({'name': name, 'votes': 0})
        .then((value) => print("La mascota se ingresó correctamente"))
        .catchError(
            (onError) => print("Falla en el ingreso de mascota $onError"));
  }

  updateEntry(Record record) {
    record.reference.update({'votes': record.votes + 1});
  }

  deleteEntry(Record record) {
    record.reference.delete();
  }
}
