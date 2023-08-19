import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/features/account/controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';

Future<void> loginStatusAlert(
    {required String title, required String desc, required bool isAuth}) async {
  await showDialog<void>(
    context: Halper.i.context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
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
  AccountNotifer.instance.setAccountModel(null);
}
