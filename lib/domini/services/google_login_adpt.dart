import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class GoogleLoginAdpt {
  static final _instance = GoogleLoginAdpt._internal();
  static final _clientIDWeb= "709547016796-vquhm8fbjkg0nlod6fpek1qhrb5c0ohr.apps.googleusercontent.com";
  static final _clientIDAndroid = "709547016796-1449erc1a454q58phc97hgcp2jvrtlf0.apps.googleusercontent.com";

  static final _googleSignInAndroid = GoogleSignIn();
  static final _googleSignInWeb = GoogleSignIn(clientId: _clientIDWeb);

  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  Future<GoogleSignInAccount?> login() {
    var _googleSignIn;
    if (defaultTargetPlatform == TargetPlatform.android) _googleSignIn = _googleSignInAndroid;
    else _googleSignIn = _googleSignInWeb;

    print("aaaaaaaaaaaa\n\n\n\n");
      final user = _googleSignIn.signIn();
      user.then((u) {
        ctrlPresentation.name = u?.displayName;
        ctrlPresentation.email = u?.email;
        ctrlPresentation.photoUrl = u?.photoUrl;
        print(u);
      });
      return user;
  }

  Future<GoogleSignInAccount?> logout() {
    var _googleSignIn;
    if (defaultTargetPlatform == TargetPlatform.android) _googleSignIn = _googleSignInAndroid;
    else _googleSignIn = _googleSignInWeb;

    final user = _googleSignIn.signOut();
    return user;
  }

  Future<bool> isSignIn() {
    var _googleSignIn;
    if (defaultTargetPlatform == TargetPlatform.android) _googleSignIn = _googleSignInAndroid;
    else _googleSignIn = _googleSignInWeb;

    return _googleSignIn.isSignedIn();
  }


}