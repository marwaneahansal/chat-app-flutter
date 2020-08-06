import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _user(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      return this._user(user);
    } catch (err) {
      print(err);
    }
  }

  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      FirebaseUser user = result.user;
      return this._user(user);
    } catch (err) {
      print(err);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
    }
  }
}
