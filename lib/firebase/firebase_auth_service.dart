
import 'package:evently/firebase/users_firestore_service.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  await UsersFirestoreService.addUser(id: credential.user!.uid, name: name, email: email);
   
  }

  static Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> reAuthentication({required String password}) async {
    final user = auth.currentUser!;

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
  }

  static Future<void> logoutUser() async {
    await auth.signOut();
  }

  static Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}