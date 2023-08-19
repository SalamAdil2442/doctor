import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/alert/failed_alert.dart';
import 'package:tandrustito/core/alert/loading_alert.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/views/first_screen_edit.dart';

import '../models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FirebaseUserModel?> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return FirebaseUserModel.fromSnap(snap);
  }

  Future<User?> signUpUser({
    required String? name,
    required String? email,
    required String? password,
  }) async {
    showLoadingProgressAlert();
    try {
      if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);
        logger(user.user);
        user.user?.updateDisplayName(name);
        Navigator.pushAndRemoveUntil(
            Halper.i.context,
            MaterialPageRoute(builder: (_) => const FirstScreen()),
            (route) => false);
        return user.user;
      }
    } on FirebaseAuthException catch (err) {
      Halper.i.pop();
      logger(err);
      failedAlert(desc: err.message ?? err.code);
      return null;
    } catch (err) {
      Halper.i.pop();
      logger(err);
      failedAlert(desc: err.toString());

      return null;
    }
    return null;
  }

  Future<User?> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      showLoadingProgressAlert();
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      logger(result.user);
      Halper.i.pop();
      Navigator.pushAndRemoveUntil(
          Halper.i.context,
          MaterialPageRoute(builder: (_) => const FirstScreen()),
          (route) => false);
      return result.user;
    } on FirebaseAuthException catch (err) {
      Halper.i.pop();
      failedAlert(desc: err.message ?? err.code);
      return null;
    } catch (err) {
      Halper.i.pop();
      failedAlert(desc: err.toString());

      return null;
    }
  }
}
