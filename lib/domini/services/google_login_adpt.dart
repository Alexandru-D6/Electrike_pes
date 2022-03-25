import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginAdpt {
  //static final _instance = GoogleLoginAdpt._internal();

  static final _googleSignIn = GoogleSignIn();
/*
  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();
*/
  static Future<GoogleSignInAccount?> login() => _googleSignIn.SignIn();



}