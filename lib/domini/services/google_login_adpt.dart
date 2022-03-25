import 'package:google_sign_in/google_sign_in.dart';
import '../../misc/user_preferences.dart';

class GoogleLoginAdpt {
  static final _instance = GoogleLoginAdpt._internal();
  var googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  static final _googleSignIn = GoogleSignIn();

  //User info
  var _id;
  var name;
  var email;
  var photoUrl;

  factory GoogleLoginAdpt() {
    return _instance;
  }

  GoogleLoginAdpt._internal();

  Future<GoogleSignInAccount?> login() {
      final user = _googleSignIn.signIn();
      user.then((u) {
        _id = u?.id;
        name = u?.displayName;
        email = u?.email;
        photoUrl = u?.photoUrl;
        print(u);
      });
      return user;
  }


}