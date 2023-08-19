import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/alert/confirm_alert.dart';
import 'package:tandrustito/core/alert/loading_alert.dart';
import 'package:tandrustito/core/alert/success_alert.dart';
import 'package:tandrustito/core/shared/context_extension.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/account/controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/first_screen_edit.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/languages_widget.dart';

showSetting() async {
  showModalBottomSheet(
    context: Halper.i.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
    builder: (BuildContext context) {
      return const NewWidget();
    },
  );
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics:  NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user != null)  SizedBox(height: 10),
              if (user != null)
                Text(
                  user.displayName ?? "",
                  style: context.titleStyle,
                ),
              if (user != null)  SizedBox(height: 10),
              if (user != null)  Divider(),
              // Consumer<ThemeLangNotifier>(builder: (context, myType, child) {
              //   return SwitchListTile(
              //       isThreeLine: false,
              //       activeColor: primaryColor,
              //       title: Text(Trans.darkTheme.trans(),
              //           style: const TextStyle(fontSize: 17)),
              //       value: myType.themeMode,
              //       onChanged: (value) {
              //         myType.changeTheme(!myType.themeMode);
              //       });
              // }),
              const LanguagesFlags(),
              const SizedBox(height: 8),
              if (user != null)
                TextButton(
                    onPressed: () async {
                      final res = await getConfirm(
                          desc: Trans.areYouSureToDeleteYourAccount.trans());
                      if (res == true) {
                        showLoadingProgressAlert();
                        await Future.delayed( Duration(seconds: 5));
                        context.back();
                        await successAlert(
                          title: Trans.success.trans(),
                          desc: Trans
                              .weRecivedYourRequestToDeleteYourAccountYourRequestWillBeProccessed
                              .trans(),
                        );

                        AccountNotifer.instance.setAccountModel(null);
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FirstScreen()),
                            (route) => false);
                      }
                    },
                    child: Text(
                      Trans.deleteAccount.trans(),
                      style: const TextStyle(color: Color.fromARGB(255, 134, 84, 80)),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
