import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

closeKeyBoard(BuildContext context) {
  try {
    logger("closeKeyBoard is called");
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  } catch (e) {
    logger(e);
  }
}
