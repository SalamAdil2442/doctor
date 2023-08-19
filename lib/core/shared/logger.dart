import 'package:flutter/foundation.dart';

logger(message) {
  if (!kReleaseMode) {
    debugPrint('\x1B[33m$message');
  }
}
