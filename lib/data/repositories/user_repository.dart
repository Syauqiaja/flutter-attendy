import 'dart:async';

import 'package:attendy_flutter/data/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepository{
  final FirebaseAuthenticationService _authService = Get.find<FirebaseAuthenticationService>();

  Future<User?> signUp(String email, String password, String displayName) async {
    try {
      User? user = await _authService.signUpWithEmailPassword(email, password, displayName);
      return user;
    } catch (e) {
      print('Sign-up error: $e');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      User? user = await _authService.signInWithEmailPassword(email, password);
      return user;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      print('Sign-out error: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential? user = await _authService.signInWithGoogle();
      return user;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  User getUser(){
    return _authService.currentUser!;
  }
}