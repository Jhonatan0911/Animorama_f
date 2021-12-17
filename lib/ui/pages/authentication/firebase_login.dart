import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_signup.dart';

class FirebaseLogIn extends StatefulWidget {
  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword);
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Registro con email",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: this.controllerEmail,
                decoration: InputDecoration(labelText: "Dirección de correo"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingresar correo";
                  } else if (!value.contains('@')) {
                    return "Ingresa una dirección de correo válida";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: this.controllerPassword,
                decoration: InputDecoration(labelText: "Contraseña"),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingresa contraseña";
                  } else if (value.length < 6) {
                    return "La contraseña debe tener al menos 6 caracteres";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () async {
                  // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                  FocusScope.of(context).requestFocus(FocusNode());
                  final form = _formKey.currentState;
                  form!.save();
                  if (_formKey.currentState!.validate()) {
                    await _login(controllerEmail.text, controllerPassword.text);
                  }
                },
                child: Text("Enviar"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  primary: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirebaseSignUp()));
              },
              child: Text("Crear cuenta"))
        ],
      ),
    );
  }
}
