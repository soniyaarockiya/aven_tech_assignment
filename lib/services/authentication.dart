import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


abstract class BaseAuth {
  //THESE METHODS ARE IMPLEMENTED IN AUTH CLASS , TO PROVIDE ABSTRACTION

  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();

  Future<void> signOut();

  Future<String> getEmail();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    return user.uid;
  }

  @override
  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> getEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    String userEmail = user.email.toString();
    return userEmail;
  }
}
