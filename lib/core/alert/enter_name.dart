import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';

Future<String?> enterNickname({required String desc}) async {
  TextEditingController controller = TextEditingController(text: desc);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return await showDialog<String?>(
    context: Halper.i.context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(Trans.name.trans()),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: ListBody(
              children: <Widget>[
                GeneralTextFiled(
                  validate: validateName,
                  contentPadding: const EdgeInsets.all(15),
                  showLabel: true,
                  controller: controller,
                  hintText: Trans.name.trans(),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(Trans.ok.trans()),
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                Navigator.of(context).pop(controller.text.trim());
              }
            },
          ),
        ],
      );
    },
  );
}
