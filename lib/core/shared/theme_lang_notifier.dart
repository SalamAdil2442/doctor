import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

class ThemeLangNotifier with ChangeNotifier {
  bool showInfoEdit = false;
  bool isEditEnable = false;
  setShowInfo(bool val) {
    showInfoEdit = val;
    isEditEnable = val;
    notifyListeners();
  }

  static final ThemeLangNotifier _singleton = ThemeLangNotifier._();
  static ThemeLangNotifier get instance => _singleton;
  ThemeLangNotifier._();
  File? file;
  setFile(File? file) {
    this.file = file;
    notifyListeners();
  }

  String lang = "en";
  bool isEn = true;
  // bool reciveNotifications = true;
  // toggleReciveNotifactions(bool reciveNotificationsParam) {
  //   reciveNotifications = reciveNotificationsParam;
  //   notifyListeners();
  // }

  bool themeMode = false;
  init() {
    lang = SharedPrefsHalper.instance.lang;
    themeMode = SharedPrefsHalper.instance.themeMode;
    if (FirebaseAuth.instance.currentUser != null) {
      showInfoEdit = true;
      notifyListeners();
    }
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null && isEditEnable) {
        showInfoEdit = true;
        notifyListeners();
      } else {
        showInfoEdit = false;
        notifyListeners();
      }
    });
  }

  changeLang(String newLang) {
    lang = newLang;
    isEn = lang == "en";
    SharedPrefsHalper.instance.setLang(newLang);
    notifyListeners();
  }

  changeTheme(bool mod) async {
    themeMode = mod;
    SharedPrefsHalper.instance.setMode(mod);
    notifyListeners();
  }
}
