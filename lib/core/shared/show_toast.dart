import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tandrustito/core/shared/imports.dart';

showToast(String title,
    {ToastGravity toastGravity = ToastGravity.BOTTOM,
    Toast toastLength = Toast.LENGTH_SHORT}) async {
  logger("_isToastOpen = false;  $_isToastOpen ");
  if (_isToastOpen == true && !kIsWeb) {
    await Fluttertoast.cancel();
  }
  _isToastOpen = await Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      fontSize: Responsive.instance.setSp(18));
}

bool? _isToastOpen = false;
