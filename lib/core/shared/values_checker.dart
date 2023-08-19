import 'package:tandrustito/core/shared/imports.dart';

bool checkIsNull(var str) {
  return [null, "null", ""].contains(str);
}

bool checkBool(var str, {bool def = false}) {
  if (checkIsNull(str)) {
    return def;
  }
  return ["true", "True", true, "1", 1].contains(str);
}

double checkDouble(var str, {double defaultV = 0.0}) {
  try {
    return double.tryParse("$str") ?? defaultV;
  } catch (e, c) {
    recoredError(e, c);
    return defaultV;
  }
}

int checkInt(var str, {int defaultV = 0}) {
  try {
    return int.tryParse("$str") ?? defaultV;
  } catch (e, c) {
    recoredError(e, c);
    return defaultV;
  }
}

bool isSuccess(int? code) {
  return (code ?? 400) ~/ 100 == 2;
}

String formatDistance(num distance) {
  if (distance > 100000) {
    return "+99";
  } else {
    return (distance / 1000).toStringAsFixed(2);
  }
}
