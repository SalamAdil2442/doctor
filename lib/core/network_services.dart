import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tandrustito/core/alert/failed_alert.dart';
import 'package:tandrustito/core/alert/loading_alert.dart';
import 'package:tandrustito/core/alert/login_alert.dart';
import 'package:tandrustito/core/alert/success_alert.dart';
import 'package:tandrustito/core/error/error_checker.dart';
import 'package:tandrustito/core/error/failure_message_model.dart';
import 'package:tandrustito/core/error/failures.dart';
import 'package:tandrustito/core/parser/remote_object_parser.dart';
import 'package:tandrustito/core/parser/server_error_parser.dart';
import 'package:tandrustito/core/shared/error_string.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/localization/translate_keys.dart';

RemoveDataSourceImp removeDataSourceImp = RemoveDataSourceImp();

class RemoveDataSourceImp {
  final _dio = dio.Dio()
    ..options.baseUrl = apiUrl
    ..options.responseType = dio.ResponseType.json;
  final String _appUrl = api;
  bool showLogs = true;
  logData(http.Response response) {
    logger("${response.request?.method} ${response.request?.url}");
    logger("response.statusCode ${response.headers}");
  }

  logDioData(dio.Response<dynamic> response) {
    if (showLogs) {
      logger(
          "${response.requestOptions.method} ${response.requestOptions.baseUrl}");
      logger("${response.statusCode} data: ${response.headers}");
    }
  }

  Future<Either<Failure, T?>> create<T>({
    required String endPoint,
    String? name,
    List<String> paths = const [],
    Map<String, dynamic> params = const {},
    required Map<String, dynamic> data,
    String? errorMsg,
    bool isFormData = false,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    ShowLoading showLoading = ShowLoading.No,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await _dio.post(
        endPoint,
        options: dio.Options(
            responseType: dio.ResponseType.json,
            validateStatus: (status) {
              return true;
            },
            contentType: "application/json; charset=utf-8",
            headers: Halper.i.getAppHeader(isJson: !isFormData)),
        data: isFormData ? await _formData(paths, data) : jsonEncode(data),
        onSendProgress: (received, total) {
          if (total != -1) {
            logger("${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      ).timeout(duration_120);
      _closeLoading(showLoading);
      logDioData(response);
      if (isSuccess(response.statusCode)) {
        await _showSuccessMessage(
            showMessage,
            getMessageFailer(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessAddOne));
        final d = parseBodyOne(ResRemote<T>(
            parseBody: ParseBody.direct,
            body: response.data,
            fromJsonModel: fromJsonModel));
        return Right(d);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            statusCode: response.statusCode ?? 0,
            reason: parseServerError(
                response.data,
                Trans.youAreNotAuthorizedReloginAndRetryAgain.trans(),
                response.statusCode ?? 400));
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.reason, isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            operationType: OperationType.FailedAddOne,
            message: errorMsg,
            statusCode: response.statusCode ?? 0,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode ?? 400));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      recoredError(e, c);
      _closeLoading(showLoading);
      logger("Error $endPoint $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);
        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(ErrorFailure(error: error));
      }
    }
  }

  Future<Either<Failure, bool>> delete(
      {required String endPoint,
      String? errorMsg,
      ShowLoading showLoading = ShowLoading.No,
      String? name,
      int popUpTimes = 0,
      Map<String, dynamic> params = const {},
      ShowMessageEnum showMessage = ShowMessageEnum.none,
      String? successMsg}) async {
    try {
      _showLoading(showLoading);
      final response = await http
          .delete(Uri.http(_appUrl, endPoint, params),
              headers: Halper.i.getAppHeader())
          .timeout(duration_120);
      await _closeLoading(showLoading);
      logData(response);
      if (isSuccess(response.statusCode)) {
        _popUpTimes(popUpTimes);
        await _showSuccessMessage(
            showMessage,
            getMessageFailer(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessDelete));
        return const Right(true);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            statusCode: response.statusCode,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            operationType: OperationType.FailedDelete,
            message: errorMsg,
            statusCode: response.statusCode,
            name: name,
            reason: parseServerError(
                response.body,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      recoredError(e, c);
      _closeLoading(showLoading);
      logger("Error $endPoint Delete $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);
        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(ErrorFailure(error: error));
      }
    }
  }

  Future<Either<Failure, List<T>>> getData<T>({
    required String endPoint,
    ShowLoading showLoading = ShowLoading.No,
    String? name,
    ParseBody parseBody = ParseBody.direct,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    Map<String, dynamic> params = const {},
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    String? errorMsg,
    String? successMsg,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await http
          .get(Uri.http(_appUrl, endPoint, params),
              headers: Halper.i.getAppHeader())
          .timeout(duration_120);
      _closeLoading(showLoading);
      logData(response);
      if (isSuccess(response.statusCode)) {
        ThemeLangNotifier.instance
            .setShowInfo(checkBool(response.headers['show']));
        final List<T> res = await compute(
            parseBodyList,
            ResRemote<T>(
                parseBody: parseBody,
                body: response.body,
                fromJsonModel: fromJsonModel));
        await _showSuccessMessage(
            showMessage,
            getMessageFailer(
                length: res.length,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetAll));

        return Right(res);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            statusCode: response.statusCode,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());

        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            operationType: OperationType.FailedGetAll,
            message: errorMsg,
            statusCode: response.statusCode,
            name: name,
            reason: parseServerError(
                response.body,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      recoredError(e, c);
      _closeLoading(showLoading);
      logger("Error $endPoint get $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);
        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(ErrorFailure(error: error));
      }
    }
  }

  Future<Either<Failure, T?>> getOne<T>({
    required String endPoint,
    String? name,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    Map<String, dynamic> params = const {},
    String? errorMsg,
    String? successMsg,
    ShowLoading showLoading = ShowLoading.No,
  }) async {
    try {
      _showLoading(showLoading);
      final response = await http
          .get(Uri.http(_appUrl, endPoint, params),
              headers: Halper.i.getAppHeader())
          .timeout(duration_120);
      _closeLoading(showLoading);
      logData(response);
      if (isSuccess(response.statusCode)) {
        await _showSuccessMessage(
            showMessage,
            getMessageFailer(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetOne));

        final d = parseBodyOne(ResRemote<T>(
            parseBody: ParseBody.direct,
            body: response.body,
            fromJsonModel: fromJsonModel));
        return Right(d);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            statusCode: response.statusCode,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            operationType: OperationType.FailedGetOne,
            message: errorMsg,
            statusCode: response.statusCode,
            name: name,
            reason: parseServerError(
                response.body,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      recoredError(e, c);
      _closeLoading(showLoading);
      logger("Error $endPoint getone $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);
        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(ErrorFailure(error: error));
      }
    }
  }

  Future<Either<Failure, T?>> update<T>({
    required String endPoint,
    String? name,
    List<String> paths = const [],
    bool isFormData = false,
    int popUpTimes = 0,
    ShowLoading showLoading = ShowLoading.No,
    required Map<String, dynamic> body,
    Map<String, String> params = const {},
    String? errorMsg,
    String? successMsg,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    try {
      logger(body);
      _showLoading(showLoading);
      final response = await _dio.put(endPoint,
          options: dio.Options(
              responseType: dio.ResponseType.json,
              validateStatus: (status) {
                return true;
              },
              contentType: "application/json; charset=utf-8",
              headers: Halper.i.getAppHeader(isJson: !isFormData)),
          data: isFormData ? await _formData(paths, body) : jsonEncode(body),
          onSendProgress: (received, total) {
        if (total != -1) {
          logger("${(received / total * 100).toStringAsFixed(0)}%");
        }
      }).timeout(duration_120);
      logger("end ${DateTime.now()}");

      _closeLoading(showLoading);
      logDioData(response);
      if (isSuccess(response.statusCode)) {
        _popUpTimes(popUpTimes);
        await _showSuccessMessage(
            showMessage,
            getMessageFailer(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessUpdate));
        logger("_showSuccessMessage ${DateTime.now()}");
        final d = parseBodyOne(ResRemote<T>(
            parseBody: ParseBody.direct,
            body: response.data,
            fromJsonModel: fromJsonModel));

        return Right(d);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            statusCode: response.statusCode ?? 0,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);
        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            operationType: OperationType.FailedUpdate,
            message: errorMsg,
            statusCode: response.statusCode ?? 0,
            name: name,
            reason: parseServerError(
                response.data,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode ?? 400));
        await _showErrorMessage(showMessage, error);
        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      recoredError(e, c);
      _closeLoading(showLoading);
      logger("Error put $endPoint $e");

      if (checkIsNetError(e)) {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageFailer(
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);
        return Left(ErrorFailure(error: error));
      }
    }
  }

  _showLoading(ShowLoading showLoading) {
    if (showLoading == ShowLoading.Show) {
      showLoadingProgressAlert();
    }
  }

  _closeLoading(ShowLoading showLoading) {
    if (showLoading == ShowLoading.Show) {
      Halper.i.pop();
    }
  }

  _popUpTimes(int popUpTimes) {
    for (var i = 0; i < popUpTimes; i++) {
      Halper.i.pop();
    }
  }

  _showErrorMessage(ShowMessageEnum showMessageEnum, FailureMessage message) {
    if (!showMessageEnum.nono) {
      failedAlert(title: Trans.failed.trans(), desc: message.reason);
    }
  }

  Future _showSuccessMessage(
      ShowMessageEnum showMessageEnum, FailureMessage message) async {
    if (showMessageEnum.successAlert) {
      await successAlert(title: Trans.success.trans(), desc: message.message);
    }
  }

  Future<dio.FormData> _formData(
      List<String> paths, Map<String, dynamic> maps) async {
    logger("maps $maps ,paths $paths");
    if (paths.isEmpty) {
      return dio.FormData.fromMap({...maps});
    } else {
      List<dio.MultipartFile> files = [];
      for (var e in paths) {
        files.add(
            await dio.MultipartFile.fromFile(e, filename: e.split('/').last));
      }
      return dio.FormData.fromMap({...maps, 'formFiles': files});
    }
  }
}
