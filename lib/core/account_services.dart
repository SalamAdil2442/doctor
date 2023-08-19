import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/alert/failed_alert.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/verification_code_screen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/home.dart';

class PhoneNumberVerifactionServices {
  static final PhoneNumberVerifactionServices _singleton =
      PhoneNumberVerifactionServices._();
  static PhoneNumberVerifactionServices get i => _singleton;
  PhoneNumberVerifactionServices._();
  String verificationId = "";
  String phone = "";
  bool isChangePhoneNumber = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> sendCode(
      String phoneNumber, bool isChangePhoneNumberParam) async {
    isChangePhoneNumber = isChangePhoneNumberParam;
    phone = phoneNumber.contains('+') ? phoneNumber : '+$phoneNumber';
    autoTimeout(String verId) {
      verificationId = verId;
    }

    autoComplete(PhoneAuthCredential phoneAuthCredential) async {
      UserCredential result = await _auth
          .signInWithCredential(phoneAuthCredential)
          .timeout(const Duration(seconds: 10));
      if (result.user != null) {
      } else {
        failedAlert(desc: Trans.operationFalied.trans());
      }
    }

    verificationfailed(FirebaseAuthException authException) {
      logger(authException);
      Halper.i.pop();

      failedAlert(desc: authException.message.toString());
    }

    codeSent(String verId, [int? forceResend]) {
      verificationId = verId;
      Halper.i.pop();

      Navigator.push(
          Halper.i.context,
          MaterialPageRoute(
              builder: (_) => VerifactionCodeScreen(phoneNumber: phone)));
    }

    logger(phoneNumber.contains('+') ? phoneNumber : '+$phoneNumber');
    _auth
        .verifyPhoneNumber(
            phoneNumber:
                phoneNumber.contains('+') ? phoneNumber : '+$phoneNumber',
            timeout: duration_120,
            verificationCompleted: autoComplete,
            verificationFailed: verificationfailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: autoTimeout)
        .timeout(const Duration(seconds: 15));
  }

  Future<void> enterCode(String code) async {
    logger("code  $code");
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      UserCredential result = await _auth
          .signInWithCredential(credential)
          .timeout(const Duration(seconds: 10));

      User? user = result.user;

      if (user != null) {
        Navigator.pushAndRemoveUntil(
            Halper.i.context,
            MaterialPageRoute(
                builder: (_) => const HomePage(
                       index: 0,
                    )),
            (route) => false);
      } else {
        Halper.i.pop();
        failedAlert(desc: Trans.operationFalied.trans());
      }
    } on FirebaseAuthException catch (e, c) {
      recoredError(e, c);
      logger(e);

      Halper.i.pop();
      failedAlert(desc: e.message.toString());
    } on Exception catch (e, c) {
      recoredError(e, c);
      logger("Exception  $e");
      Halper.i.pop();

      failedAlert(desc: e.toString());
    }
  }
}
