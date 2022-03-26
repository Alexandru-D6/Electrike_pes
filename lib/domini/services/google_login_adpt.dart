// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginAdpt {
  static final _instance = GoogleLoginAdpt._internal();
  static const _clientIDWeb= "709547016796-vquhm8fbjkg0nlod6fpek1qhrb5c0ohr.apps.googleusercontent.com";
  //static const _clientIDAndroid = "709547016796-1449erc1a454q58phc97hgcp2jvrtlf0.apps.googleusercontent.com";
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  Future<GoogleSignInAccount?> login() {
      final user = _googleSignIn.signIn();
      user.then((u) {
        var _name = u?.displayName;
        var _email = u?.email;
        var _photoUrl = u?.photoUrl;

        if(_name != null) {
          ctrlPresentation.name = _name;
        } else {
          ctrlPresentation.name = "";
        }

        if(_email != null) {
          ctrlPresentation.email = _email;
        } else {
          ctrlPresentation.email = "";
        }

        if(_photoUrl != null) {
          ctrlPresentation.photoUrl = _photoUrl;
        } else {
          ctrlPresentation.photoUrl = "https://avatars.githubusercontent.com/u/75260498?v=4&auto=format&fit=crop&w=5&q=80";
        }
      });
      return user;
  }

  Future<GoogleSignInAccount?> logout() {
    _googleSignIn.disconnect();
    final user = _googleSignIn.signOut();
    return user;
  }

  Future<bool> isSignIn() {
    return _googleSignIn.isSignedIn();
  }


}