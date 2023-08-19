import 'package:flutter/material.dart';
import 'package:tandrustito/localization/translate_keys.dart';

Future<TimeOfDay?> showCustomeTimePicker(
    BuildContext context, TimeOfDay? initTime) async {
  final TimeOfDay? newTime = await showTimePicker(
    context: context,
    initialTime: initTime ?? const TimeOfDay(hour: 7, minute: 15),
  );
  return newTime;
}

String? formatTimeOfDay(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) {
    return "";
  }
  String hour = "${timeOfDay.hour < 12 ? timeOfDay.hour : timeOfDay.hour - 12}";
  if (hour.length < 2) {
    hour = "0$hour";
  }
  String minute = timeOfDay.minute.toString();
  if (minute.length < 2) {
    minute = "0$minute";
  }
  return "$hour:$minute ${timeOfDay.period.name.toLowerCase().trans()}";
}

TimeOfDay? getTimeOfDay(var t) {
  return t != null
      ? t is TimeOfDay
          ? t
          : TimeOfDay(
              hour: int.parse(t?.split(":")[0]),
              minute: int.parse(t?.split(":")[1]))
      : null;
}
