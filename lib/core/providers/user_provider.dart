import 'package:flutter/material.dart';
import 'package:tandrustito/core/providers/models/user_model.dart';
import 'package:tandrustito/core/providers/services/auth_methods.dart';

class UserProvider with ChangeNotifier {
  FirebaseUserModel? _user;
  final AuthMethods _authMethods = AuthMethods();
  FirebaseUserModel? get getUser => _user;
  Future<void> refreshUser() async {
    FirebaseUserModel? user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
