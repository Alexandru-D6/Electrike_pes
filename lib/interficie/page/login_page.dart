import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LogPage createState() => LogPage();
}

class LogPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Electrike",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), //TODO traductor
              ),
              const Text(
                "Emprén un nou viatge",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), //TODO traductor
              ),
              Positioned(child: Image.asset('assets/images/LogoElectrike.png', width: size.width* 0.25)),
              const SizedBox(height: 50),
              const Text(
                "Fes Login amb Google",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), //TODO traductor
              ),
              const SizedBox(height: 50),
              SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: () {
                    //print('click');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}