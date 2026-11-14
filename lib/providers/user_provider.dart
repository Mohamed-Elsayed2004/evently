import 'dart:async';
import 'package:evently/firebase/users_firestore_service.dart';
import 'package:evently/model/user_model.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;
  String? errorMessage;

  StreamSubscription<UserModel>? _userSubscription;

  Future<void> userStreamTrigger() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await _userSubscription?.cancel();

    _userSubscription = UsersFirestoreService.getUser().listen(
      (userData) {
        user = userData;
        isLoading = false;
        errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        errorMessage = error.toString();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
