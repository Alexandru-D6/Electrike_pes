import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginAdpt {
  static final _instance = GoogleLoginAdpt._internal();
  var googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  static final _googleSignIn = GoogleSignIn();

  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();

  Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();


}