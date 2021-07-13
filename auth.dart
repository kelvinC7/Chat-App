import 'package:Agriculture/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Agriculture/user.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModal _userFromFirebaseUser(FirebaseUser user) {
    //  HelperFunctions.saveUserIDSharedPreference(user.uid);
    return user != null ? UserModal(uid: user.uid) : null;
  }

  Future signInWithEnmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
