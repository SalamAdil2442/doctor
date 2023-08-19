import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';

Future<void> permissionNotAllowedAlert(
    {required String error, String? title, Function()? onTap}) async {
  title ??= Trans.failed.trans();
  await AwesomeDialog(
          context: Halper.i.context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: title,
          desc: error,
          titleTextStyle: Halper.i.context.titleStyle,
          descTextStyle: Halper.i.context.subTitleStyle,
          btnCancelText: onTap == null ? null : Trans.ignore.trans(),
          btnCancelOnPress: onTap == null ? null : () {},
          btnOkText: Trans.allow.trans(),
          btnOkOnPress: onTap)
      .show();
}
