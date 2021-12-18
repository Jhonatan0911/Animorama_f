import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f_202110_firebase/domain/managements/auth_management.dart';


class AuthenticationController extends GetxController {

  final _authenticated = false.obs;
  final _currentUser = Rx<User?>(null);
 

  set currentUser(User? userAuth) {
    _currentUser.value = userAuth;
    _authenticated.value = userAuth != null;
  }

  // Reactive Getters
  RxBool get reactiveAuth => _authenticated;
  Rx<User?> get reactiveUser => _currentUser;

  // Getters
  bool get authenticated => _authenticated.value;
  User? get currentUser => _currentUser.value;



  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      print('OK');
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NOK 1');
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        print('NOK 2');
        return Future.error("Wrong password");
      }
    }
    print('NOK');
  }

  Future<void> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  String userUid() {
    String _uid = FirebaseAuth.instance.currentUser!.uid ;
    return _uid;
  }

  String userName() {
    String name = FirebaseAuth.instance.currentUser!.displayName ?? "User";
    return name;
  }

}
