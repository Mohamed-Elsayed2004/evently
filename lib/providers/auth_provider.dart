import 'package:evently/firebase/events_firestore_service.dart';
import 'package:evently/firebase/firebase_auth_service.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderService extends ChangeNotifier {
  String? errorMessage;
  bool isLoading = false;
  UserModel? currentUser;

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    errorMessage = null;
    isLoading = true;
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
    } finally {
      isLoading = false;
      notifyListeners();
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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  listenToAuthChange() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        currentUser = UserModel(id: user.uid, email: user.email!, name: '');
      } else {
        currentUser = null;
      }
      notifyListeners();
    });
  }

  
}
