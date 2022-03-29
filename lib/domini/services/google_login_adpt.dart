// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class GoogleLoginAdpt {
  static final _instance = GoogleLoginAdpt._internal();
  static const _clientIDWeb= "709547016796-vquhm8fbjkg0nlod6fpek1qhrb5c0ohr.apps.googleusercontent.com";
  //static const _clientIDAndroid = "709547016796-1449erc1a454q58phc97hgcp2jvrtlf0.apps.googleusercontent.com";

  static final _googleSignInAndroid = GoogleSignIn();
  static final _googleSignInWeb = GoogleSignIn(clientId: _clientIDWeb);

  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();
  CtrlDomain ctrlDomain = CtrlDomain();

  Future<GoogleSignInAccount?> login() {
    var _googleSignIn = _googleSignInWeb;
    if (defaultTargetPlatform == TargetPlatform.android) {
      _googleSignIn = _googleSignInAndroid;
    }

      final user = _googleSignIn.signIn();
      user.then((u) {
        late String name, email, photoUrl;
        if(u?.displayName != null) name = u!.displayName.toString();
        if(u?.email != null) email = u!.email.toString();
        if(u?.photoUrl != null) photoUrl = u!.photoUrl.toString();

        ctrlDomain.initializeUser(email, name, photoUrl);
      });
      return user;
  }

  Future<GoogleSignInAccount?> logout() {
    var _googleSignIn = _googleSignInAndroid;
    if (defaultTargetPlatform == TargetPlatform.android) {
      _googleSignIn = _googleSignInAndroid;
    }

    ctrlDomain.resetUserSystem();

    _googleSignIn.disconnect();
    final user = _googleSignIn.signOut();
    return user;
  }

  Future<bool> isSignIn() {
    var _googleSignIn = _googleSignInWeb;
    if (defaultTargetPlatform == TargetPlatform.android) {
      _googleSignIn = _googleSignInAndroid;
    }

    return _googleSignIn.isSignedIn();
  }


}