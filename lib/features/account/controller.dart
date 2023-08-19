import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/account/model.dart';

class AccountNotifer extends ChangeNotifier {
  static final AccountNotifer _singleton = AccountNotifer._();
  static AccountNotifer get instance => _singleton;
  AccountModel? accountModel;
  AccountNotifer._();
  setAccountModel(AccountModel? model) {
    accountModel = model;
    if (accountModel == null) {
      SharedPrefsHalper.instance.deleteAccount();
    } else {
      SharedPrefsHalper.instance.setAccount(model!);
    }
    notifyListeners();
  }

  Future getAccount() async {
    accountModel = await SharedPrefsHalper.instance.getAccount();
    notifyListeners();
  }
}
