import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/localization/translate_keys.dart';

Future<void> failedAlert({ String? title, required String desc}) async {
  return showDialog<void>(
    context: Halper.i.context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? Trans.failed.trans()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(desc),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(Trans.ok.trans()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
