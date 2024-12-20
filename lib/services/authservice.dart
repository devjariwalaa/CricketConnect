import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> googleSignIn() async {
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        throw Exception("User canceled the sign-in process.");
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error during Google Sign-In: $e");
      rethrow;
    }
  }
}