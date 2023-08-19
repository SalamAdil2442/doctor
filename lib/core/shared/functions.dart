import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/account/controller.dart';

recoredError(e, c) {
  if (kReleaseMode) {
    FirebaseCrashlytics.instance.recordError(e, c);
  }
}

TextDirection getTextDirection(String text) {
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

bool get isLogin =>
    AccountNotifer.instance.accountModel != null ||
    FirebaseAuth.instance.currentUser != null;
bool get canEdit =>
    AccountNotifer.instance.accountModel != null ||
    (FirebaseAuth.instance.currentUser != null &&
        ThemeLangNotifier.instance.showInfoEdit);

//

String checkOnNullReturnEmpty(String? str, {String def = ""}) {
  if (["", null, "null"].contains(str)) {
    return def;
  }
  return str ?? "";
}

String? formatAttachment(String? val) {
  return checkIsNull(val) == true ||
          val.toString().toLowerCase().contains("error")
      ? null
      : val.toString().contains("http")
          ? val
          : "https://   .com/${val.toString().replaceAll("\\", "/")}";
}

String getPhone(String? t) {
  if (checkIsNull(t)) {
    return "";
  } else if (t!.toString().startsWith("+964")) {
    return t.replaceAll("+964", "");
  } else if (t.toString().startsWith("964")) {
    return t.replaceAll("964", "");
  }
  return t;
}

TextDirection isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}
