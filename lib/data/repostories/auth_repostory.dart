import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tiktok_clone/data/exeptions/auth_exceptions.dart';

class AuthRepostory {
  final FirebaseAuth _auth;
  AuthRepostory({
    FirebaseAuth? firebaseAuth,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance;

  // sign up
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  // sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  // sign in with google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }

  //log out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw AuthError.from(
        FirebaseAuthException(
          code: e.toString(),
        ),
      );
    }
  }
}
