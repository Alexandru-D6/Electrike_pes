import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';


class LoginPage extends StatefulWidget {
  @override
  login_page createState() => login_page();
}

class login_page extends State<LoginPage> {
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
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: () {
                    print('click');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}