import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/localization/translate_keys.dart';

Future<bool> getConfirm({required String desc}) async {
  final res = await showDialog<bool?>(
    context: Halper.i.context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(Trans.warning.trans()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(desc)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(Trans.no.trans()),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(Trans.ok.trans()),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
  return res == true;
}
