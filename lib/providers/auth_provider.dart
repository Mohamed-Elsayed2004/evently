import 'package:evently/firebase/firebase_auth_service.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderService extends ChangeNotifier {
  String? errorMessage;
  bool isLoading = false;
  UserModel? currentUser;
  bool isEmailVerified = false;
  bool isAuthInitialized = false;

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

  void listenToAuthChange() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await user.reload();

        final updatedUser = FirebaseAuth.instance.currentUser;

        if (updatedUser != null) {
          currentUser = UserModel(
            id: updatedUser.uid,
            email: updatedUser.email!,
            name: '',
          );

          isEmailVerified = updatedUser.emailVerified;
        } else {
          currentUser = null;
          isEmailVerified = false;
        }
      } else {
        currentUser = null;
        isEmailVerified = false;
      }
      isAuthInitialized = true;
      notifyListeners();
    });
  }

  Future<void> triggerLogout() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      await FirebaseAuthService.logoutUser();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPasswordTrigger({required String email}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      await FirebaseAuthService.resetPassword(email: email);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser?.reload();

    final user = FirebaseAuth.instance.currentUser;

    isEmailVerified = user?.emailVerified ?? false;

    notifyListeners();
  }
}
