import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:tandrustito/core/shared/imports.dart';

class ConnectionNotifier with ChangeNotifier {
  static final ConnectionNotifier _singleton = ConnectionNotifier._();
  static ConnectionNotifier get instance => _singleton;
  ConnectionNotifier._();

  //check if mobile contains gms google mobile services
  bool isGMS = true;
  //check  internet connection

  isGoogle() async {
    if (Platform.isIOS) {
      isGMS = true;
    } else {
      try {
        GooglePlayServicesAvailability availability =
            await GoogleApiAvailability.instance
                .checkGooglePlayServicesAvailability();
        logger("availability $availability");
        if ([
          GooglePlayServicesAvailability.serviceVersionUpdateRequired,
          GooglePlayServicesAvailability.success,
          GooglePlayServicesAvailability.serviceUpdating
        ].contains(availability)) {
          isGMS = true;
        } else {
          isGMS = false;
        }
      } catch (e, c) {
        logger("erron in check gogle $e");
        recoredError(c, c);
        isGMS = false;
      }
    }

    notifyListeners();
  }
}
