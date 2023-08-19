import 'dart:convert';

import 'package:tandrustito/localization/translate_keys.dart';

String parseServerError(String res, String def, int statusCode) {
  try {
    if (statusCode == 405) {
      return Trans.youHaveNotPermissonToDoThat.trans();
    }
    var body = jsonDecode(res);
    String? error = body['message'];

    return error ?? def;
  } catch (e) {
    try {
      String error = res;
      return error;
    } catch (e) {
      return def;
    }
  }
}
