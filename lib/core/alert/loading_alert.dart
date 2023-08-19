import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

Future<void> showLoadingProgressAlert() async {
  BuildContext context = Halper.i.context;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: const Center(
              child: CircularProgressIndicator(
                  // value: myType.current == myType.total &&
                  //         myType.current == 0
                  //     ? null
                  //     : myType.current / myType.total,
                  )));
    },
  );
}
