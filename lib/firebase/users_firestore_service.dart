import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/user_model.dart';
import 'package:evently/utils/app_firestore_collections.dart';

class UsersFirestoreService {
  static final userRef = FirebaseFirestore.instance
      .collection(AppFirestoreCollections.users)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  static Future<void> addUser({
    required String id,
    required String name,
    required String email,
    
  }) async {
    await userRef
        .doc(id)
        .set(
          UserModel(
            id: id,
            name: name,
             email: email,
          ),
        );
  }

  static Stream<UserModel> getUser({required String uid}) {
  return userRef.doc(uid).snapshots().map(
    (snapshot) => snapshot.data()!,
  );
}

  static Future<void> updateUser({
    required String uid,
    required UserModel userModel,
  }) async {
    await userRef.doc(uid).update(userModel.toJson());
  }

  static Future<void> deleteUser({required String uid}) async {
  await userRef.doc(uid).delete();
}
}