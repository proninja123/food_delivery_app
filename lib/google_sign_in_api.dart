import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAPi {
  static final  _androidClientId = '1040429840464-al4s9g1d08bhe11fs54dcn8evefpmng8.apps.googleusercontent.com';
  //static final _googleSignIn = GoogleSignIn(clientId: _androidClientId);
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount> login() =>_googleSignIn.signIn();
  static Future logout() =>_googleSignIn.disconnect();

}