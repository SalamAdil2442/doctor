import 'package:tandrustito/core/shared/imports.dart';

class FailureMessage {
  String reason;
  String message;
  String elementLoaded;
  FailureMessage(
      {required this.reason,
      required this.message,
      required this.elementLoaded});

  @override
  String toString() {
    return [message, reason, elementLoaded]
        .where((element) => !checkIsNull(element))
        .toList()
        .join("\n");
  }
}
