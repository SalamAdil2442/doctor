import 'dart:io';
import 'dart:math';

import 'package:huawei_location/huawei_location.dart' as hms;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tandrustito/core/alert/failed_alert.dart';
import 'package:tandrustito/core/shared/connection_checker_notifier.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/permissions_halper.dart';

class LocationHalper {
  static final LocationHalper _singleton = LocationHalper._();
  static LocationHalper get instance => _singleton;
  LocationHalper._();
  bool isAlertShowing = false;
  final Location _location = Location();
  LatLng? latlng;
  _close(bool closeAlert) {
    if (closeAlert) {
      Halper.i.pop();
    }
  }

  ///close alert  is used for close dialog
  ///
  /// forceRefresh to get new location
  Future<LatLng?> getLocation(bool closeAlert,
      {bool forceRefresh = true}) async {
    bool isGoogle = ConnectionNotifier.instance.isGMS;
    logger("isSupporGoolge $isGoogle");
    if (isGoogle || Platform.isIOS) {
      return _getGMSLocation(closeAlert, forceRefresh: forceRefresh);
    } else {
      return _getHMSLocation(closeAlert, forceRefresh: forceRefresh);
    }
  }

  Future changeSettings() async {
    try {
      await _location
          .changeSettings(accuracy: LocationAccuracy.high)
          .timeout(duration_20);
    } catch (e) {
      logger("e $e");
    }
  }

  Future<LatLng?> _getGMSLocation(bool closeAlert,
      {bool forceRefresh = true}) async {
    logger("position $latlng ${latlng != null && forceRefresh == false}");
    try {
      bool isGpsOn = false;
      bool isGranted = await PermissionHalper.instance.isHasPermission();
      logger("isGranted $isGranted");
      if (!isGranted) {
        _close(closeAlert);
        await PermissionHalper.instance.requestPermission();
        return null;
      }
      isGpsOn = await isGpsOnFun();
      logger("isGpsOn   $isGpsOn");
      if (isGpsOn == false) {
        gpsOffAlert(true);
        return null;
      }
      if (isGpsOn == true) {
        changeSettings();
        logger(DateTime.now());
        final position = await _location.getLocation().timeout(duration_20);
        logger(position);
        if (position.isMock != false) {
          throw Exception();
        }
        latlng = LatLng(position.latitude!, position.longitude!);
        _close(closeAlert);
        return latlng;
      } else {
        _close(closeAlert);
        gpsOffAlert(true);
        return null;
      }
    } on Exception catch (e, c) {
      recoredError(e, c);
      _close(closeAlert);
      failedAlert(
          title: Trans.failed.trans(),
          desc: Trans.canNotGetTheCurrentLocationRetryAgain.trans());
      logger("Exception    in get postion $e ${StackTrace.current}");
      return null;
    }
  }

  gpsOffAlert(bool isGMS) {
    failedAlert(
        title: Trans.failed.trans(),
        desc: Trans.pleaseEnableGpsToContinue.trans());
  }

  Future<bool> isGpsOnFun() async {
    try {
      return await _location.serviceEnabled().timeout(duration_20);
    } catch (e) {
      return false;
    }
  }

  Future<LatLng?> _getHMSLocation(bool isAlertOpen,
      {bool forceRefresh = true}) async {
    try {
      final hms.FusedLocationProviderClient locationService =
          hms.FusedLocationProviderClient();
      logger("_getHMSLocation");
      bool isGranted = await PermissionHalper.instance.isHasPermission();
      logger("isGranted $isGranted");
      if (!isGranted) {
        _close(true);
        await PermissionHalper.instance.requestPermission();
        return null;
      }
      var isGpsOn = await isGpsOnFun();
      if (isGpsOn == true) {
        await locationService.requestLocationUpdates(hms.LocationRequest());
        final location = await locationService.getLastLocation();
        logger("location $location");
        if (location.longitude != null && location.latitude != null) {
          logger("location ${location.toMap()}");
          latlng = LatLng(location.latitude!, location.longitude!);
          _close(isAlertOpen);
          return latlng;
        } else {
          failedAlert(
              title: Trans.failed.trans(),
              desc: Trans.canNotGetTheCurrentLocationRetryAgain.trans());
          return null;
        }
      } else {
        _close(true);
        gpsOffAlert(false);
        return null;
      }
    } catch (e, c) {
      recoredError(e, c);
      logger("ex $e");
      _close(true);
      failedAlert(
          title: Trans.failed.trans(),
          desc: Trans.canNotGetTheCurrentLocationRetryAgain.trans());
      return null;
    }
  }

  double calculateDistance(LatLng start, LatLng end) {
    var earthRadius = 6378137.0;
    var dLat = _toRadians(end.latitude - start.latitude);
    var dLon = _toRadians(end.longitude - start.longitude);
    var a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(start.latitude)) *
            cos(_toRadians(end.latitude));
    var c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  _toRadians(double degree) {
    return degree * pi / 180;
  }
}
