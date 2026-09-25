import 'package:evently/firebase/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderService extends ChangeNotifier {
  String? errorMessage;

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    errorMessage = null;
    try {
      await FirebaseAuthService.registerUser(
        email: email,
        password: password,
        name: name,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = FirebaseAuthService.authErrorMessage(e);
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    errorMessage = null;
    try {
      await FirebaseAuthService.loginUser(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = FirebaseAuthService.authErrorMessage(e);
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
}
