import 'package:evently/firebase/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderService extends ChangeNotifier {
  String? errorMessage;
  bool isRegisterSuccess=false;
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuthService.registerUser(
        email: email,
        password: password,
        name: name,
      );
      isRegisterSuccess=true;
    } on FirebaseAuthException catch (e) {
      errorMessage = FirebaseAuthService.authErrorMessage(e);
    } catch (e) {
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
