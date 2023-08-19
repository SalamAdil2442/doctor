import 'package:flutter/material.dart';
import 'package:tandrustito/core/alert/loading_alert.dart';
import 'package:tandrustito/core/shared/enums.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controller.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controllercopy.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/days_model.dart';
import 'package:tandrustito/model/names_model.dart';
import 'package:tandrustito/views/forms_widget/time_picker.dart';
import 'package:tandrustito/views/time.dart';
import 'package:uuid/uuid.dart';

class Halper {
  static final Halper _singleton = Halper._();
  static Halper get i => _singleton;
  Halper._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get context => navigatorKey.currentContext!;
  pop({var value}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  bool get canPop => Navigator.canPop(context);
  showLoading() {
    showLoadingProgressAlert();
  }

  Map<String, String> getAppHeader({bool isJson = true}) {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      // "Authorization": "Bearer ${AccountNotifer.instance.accountModel?.token}",
    };
  }
}

String getNames(Names? names) {
  String lang = ThemeLangNotifier.instance.lang;
  if (lang == "en") {
    return names?.english ?? "";
  } else if (lang == "ar") {
    return names?.arabic ?? "";
  }
  return names?.kurdish ?? "";
}

String formatWorkTime(WorkTime workTime) {
  if (workTime.isOpen24) {
    return Trans.open24.trans();
  } else {
    return "${formatTimeOfDay(workTime.openTime)} - ${formatTimeOfDay(workTime.closeTime)}";
  }
}

String getDayClass(DayClass availableDays) {
  final data = availableDays.toMap();
  data.removeWhere((key, value) => value != true);
  return data.keys.toList().map((e) => e.trans()).join(" - ");
}

GeneralNotifier? getGeneralNotifier(ElementType elementType) {
  if (elementType == ElementType.laboratory) {
    return LabsNotifer.instance;
  } else if (elementType == ElementType.pharmacy) {
    return PharmaciesNotifer.instance;
  } else if (elementType == ElementType.doctor) {
    return DoctorsNotifer.instance;
  }
  return null;
}

var uuid = const Uuid();

String generateUid() {
  return uuid.v1();
}
