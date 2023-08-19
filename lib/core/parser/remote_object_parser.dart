import 'dart:convert';

import 'package:tandrustito/core/shared/imports.dart';

class ResRemote<T> {
  dynamic body;
  ParseBody parseBody;
  T Function(Map<String, dynamic> json) fromJsonModel;
  ResRemote(
      {required this.body,
      required this.fromJsonModel,
      required this.parseBody});
}

List<T> parseBodyList<T>(ResRemote<T> responseBody) {
  final body = jsonDecode(responseBody.body);
  if (responseBody.parseBody == ParseBody.direct) {
    return List<T>.from(
        body.map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
  } else if (responseBody.parseBody == ParseBody.row) {
    return List<T>.from(
        body['rows'].map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
  } else if (responseBody.parseBody == ParseBody.towLevelList) {
    return List<T>.from(
        body[0].map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
  }
  return <T>[];
}

T? parseBodyOne<T>(ResRemote<T> responseBody) {
  try {
    final body = (responseBody.body is! String)
        ? responseBody.body
        : jsonDecode(responseBody.body);
    if (responseBody.parseBody == ParseBody.direct) {
      return responseBody.fromJsonModel(body);
    } else if (responseBody.parseBody == ParseBody.row) {
      return responseBody.fromJsonModel(body['rows']);
    } else if (responseBody.parseBody == ParseBody.towLevelList) {
      return responseBody.fromJsonModel(body[0]);
    }
    return responseBody.fromJsonModel(body);
  } catch (e) {
    logger(e);
    return null;
  }
}
