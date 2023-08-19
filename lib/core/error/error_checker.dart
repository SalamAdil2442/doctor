import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' show ClientException;

/// check if exception is related to network
bool checkIsNetError(var e) {
  String error = e.toString();
  if (error.contains("TimeoutException") ||
      error.contains("No route to host") ||
      e is SocketException ||
      e is HttpException ||
      e is ClientException ||
      e is TimeoutException ||
      e is IOException ||
      error.contains("No route to host") ||
      error.contains("SocketException") ||
      error.contains("Connection closed before full header was received") ||
      error.contains("No address associated with hostname") ||
      error.contains("Network is unreachable")) {
    return true;
  }
  return false;
}
