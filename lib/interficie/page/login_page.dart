import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

//treure aquest import quan es tregui la funcion signIn()
import '../../domini/services/google_login_adpt.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LogPage createState() => LogPage();
}

class LogPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const FlutterLogo(size: 150),
              const SizedBox(height: 50),
              SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: signIn)
                    //print('click'),
            ],
          ),
        ),
      ),
    );
  }
}


//esta funcion iria al controlador de capa de presentacion
//que llamaria al controlador de la capa de dominio esta llamaria
//la clase google log in adapter

Future signIn() async {
  await GoogleLoginAdpt.login();
}