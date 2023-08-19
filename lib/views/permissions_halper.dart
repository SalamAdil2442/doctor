import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/permsseion_not_allowed_alert.dart';

class PermissionHalper {
  static final PermissionHalper _singleton = PermissionHalper._();
  static PermissionHalper get instance => _singleton;
  PermissionHalper._();

  Future<bool> getLocationAlwaysPermission() async {
    try {
      bool isGranted = await ph.Permission.location.request().isGranted;
      return isGranted;
    } catch (e, c) {
      recoredError(e, c);
      logger("error  in get locationAlways $e");
      return false;
    }
  }

  Future<bool> isAndroid13() async {
    // No need to ask this permission on Android 13 (API 33)
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      return (info.version.sdkInt >= 33);
    }

    return true;
  }

  Future<bool> getStoreagePermission() async {
    try {
      final isAndroid = await isAndroid13();
      bool isGranted = isAndroid
          ? await ph.Permission.photos.request().isGranted
          : await ph.Permission.storage.request().isGranted;
      if (isGranted != true) {
        await requestStoragePermission();
      }
//farmuu

      return isGranted;
    } catch (e, c) {
      recoredError(e, c);
      logger("error  in get locationAlways $e");
      return false;
    }
  }

  Future<bool> isHasPermission() async {
    try {
      ph.PermissionStatus permissionStatus =
          await ph.Permission.location.request().timeout(duration_20);
      return permissionStatus.isGranted;
    } catch (e) {
      return false;
    }
  }

  Future<void> requestPermission() async {
    try {
      await permissionNotAllowedAlert(
          onTap: ph.openAppSettings,
          error: Trans.appHasNotAccessToLocation.trans());
    } catch (e) {
      logger(e);
    }
  }

  Future<void> requestStoragePermission() async {
    try {
      await permissionNotAllowedAlert(
          onTap: ph.openAppSettings,
          error: Trans.appHasNotAccessToFiles.trans());
    } catch (e) {
      logger(e);
    }
  }
}
