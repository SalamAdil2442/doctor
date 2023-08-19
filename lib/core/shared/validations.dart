import 'package:flutter/cupertino.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/show_toast.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:url_launcher/url_launcher.dart';

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  }

  if (value.trim().length < 2) {
    return Trans.tooShort.trans();
  } else {
    return null;
  }
}

String? validateNote(String? value) {
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  }

  if (value.trim().length < 2) {
    return Trans.tooShort.trans();
  } else {
    return null;
  }
}

String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 2) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 2) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? validateUserName(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 2) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Trans.required.trans();
  } else if (value.trim().length < 6) {
    return Trans.tooShort.trans();
  }
  return null;
}

String? withoutValidate(String? value) {
  return null;
}

String? validatephoneNullAble(String? value) {
  String pattern = '^07[3-9][0-9][0-9]{7}\$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  if (!regex.hasMatch(value)) {
    return "07XX XXX XXXX";
  } else {
    return null;
  }
}

String? validatephone(String? value) {
  String pattern = '^07[0-9][0-9][0-9]{7}\$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.trim().isEmpty) {
    return Trans.required.trans();
  }
  if (!regex.hasMatch(value)) {
    return "07XX XXX XXXX";
  } else {
    return null;
  }
}

Future<void> openPhoneCall(String? phone) async {
  if (phone == null || phone == "null" || phone == "") {
    return;
  }
  String googleUrl = 'tel:$phone';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl));
  } else {
    showToast(Trans.failed.trans());
  }
}

closeKeyBoard(BuildContext context) {
  try {
    logger("closeKeyBoard");
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  } catch (e) {
    logger(e);
  }
}
