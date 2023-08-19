import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/show_toast.dart';
import 'package:tandrustito/features/account/controller.dart';
import 'package:tandrustito/features/account/model.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/first_screen_edit.dart';

class AccountServices {
  static final AccountServices _singleton = AccountServices._();
  static AccountServices get instance => _singleton;
  AccountServices._();

  Future<void> login(
      {required String password, required String username}) async {
    final model = AccountModel(username: username, password: password);
    if (model == first) {
      AccountNotifer.instance.setAccountModel(model);

      Navigator.of(Halper.i.context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (_) => const FirstScreen()),
          (route) => false);
    } else {
      showToast(Trans.wrongUserNameOrPassword.trans(),
          toastGravity: ToastGravity.CENTER);
    }
  }
}

AccountModel first =
    AccountModel(password: "1234@@Admin", username: "Admin@@1234");
