import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginHelper extends GetxController {
  /*
  * Google Sign In
  */
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  signInWithGoogle() async {
    googleAccount.value = await _googleSignIn.signIn();
  }
  signOutWithGoogle() async {
    googleAccount.value = await _googleSignIn.signOut();
  }
  /*
  * End Google Sign In
  */
}