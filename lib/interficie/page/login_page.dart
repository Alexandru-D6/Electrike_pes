import 'package:flutter/material.dart';
import 'package:flutter_project/domini/services/google_login_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:sign_button/sign_button.dart';

import '../widget/lateral_menu_widget.dart';

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
      drawer: const NavigationDrawerWidget(), //esto es para que aparezca el botón de menú lateral
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: mPrimaryColor,
      ),
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
                  onPressed: () async {
                    await serviceLocator<GoogleLoginAdpt>().login();
                    ctrlPresentation.toProfilePage(context);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}