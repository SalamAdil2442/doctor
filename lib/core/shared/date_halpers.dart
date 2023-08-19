import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';

String formatDate(DateTime date) {
  try {
    String year = date.year.toString();
    String day = date.day.toString();
    String month = date.month.toString();
    String hour = (date.hour > 12 ? date.hour - 12 : date.hour).toString();
    if (hour.length == 1) {
      hour = "0$hour";
    }
    return "$hour:${date.minute} ${date.hour > 12 ? Trans.pm.trans() : Trans.am.trans()} $day-$month-$year";
  } catch (e) {
    logger("formatDate error $e");
    return "";
  }
}

String getOnlyDate(DateTime? date) {
  if (date == null) {
    return "";
  }
  try {
    return "${date.year}-${date.month > 9 ? date.month : "0${date.month}"}-${date.day > 9 ? date.day : "0${date.day}"}";
  } catch (e) {
    logger("formatDate error $e");
    return "";
  }
}

List<String> monthsName = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
bool isToday(DateTime? date) {
  if (date == null) {
    return false;
  }
  DateTime now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

String formatTime(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) {
    return "";
  }
  return (timeOfDay
      .toString()
      .replaceAll("TimeOfDay(", "")
      .replaceAll(")", ""));
}

String formatTimeFroView(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) {
    return "";
  }
  return (timeOfDay
          .toString()
          .replaceAll("TimeOfDay(", "")
          .replaceAll(")", "")) +
      timeOfDay.period.name.toLowerCase().trans();
}

TimeOfDay? getTimeOfDay(String? v) {
  try {
    return v != null
        ? TimeOfDay(
            hour: int.parse(v.split(":")[0]),
            minute: int.parse(v.split(":")[1]))
        : null;
  } catch (e) {
    logger("getTimeOfDay $e");
  }
  return null;
}
