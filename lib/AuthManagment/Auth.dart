import 'package:chat_app/AuthManagment/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  Chat _chat = new Chat();
  bool signup;

  bool testResult(String result) {}
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic signIn(String _email, String _password) async {
    var result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      result = e;
    }
    return result;
  }

  void signOut() async {
    await _auth.signOut();
  }

  Stream<User> get listeauth {
    return _auth.authStateChanges();
  }

  Future createAccount(String _email, String _password, String _name) async {
    var result;
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User _user = _auth.currentUser;
      _chat.addUser(_email, _password, _user.uid, _name);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      result = e;
    } finally {
      return result;
    }
  }
}
