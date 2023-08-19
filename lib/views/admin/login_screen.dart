import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/features/account/services.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/genera_button.dart';

Future loginForm() {
  return showModalBottomSheet(
      context: Halper.i.context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return const _LoginScreen();
      });
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  State<_LoginScreen> createState() => __LoginScreenState();
}

class __LoginScreenState extends State<_LoginScreen> {
  final TextEditingController username =
      TextEditingController(text: kDebugMode ? first.username : "");
  final TextEditingController password =
      TextEditingController(text: kDebugMode ? first.password : "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GeneralTextFiled(
                    fillColor: Colors.transparent,
                    showLabel: true,
                    maxLines: 1,
                    viewBorder: true,
                    prefixIcon: const Icon(Icons.person),
                    textInputType: TextInputType.emailAddress,
                    contentPadding: const EdgeInsets.all(15),
                    controller: username,
                    validate: validateUserName,
                    hintText: Trans.username.trans()),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GeneralTextFiled(
                    fillColor: Colors.transparent,
                    viewBorder: true,
                    showLabel: true,
                    obscureText: isSecure,
                    prefixIcon: InkWell(
                        onTap: () {
                          isSecure = !isSecure;
                          setState(() {});
                        },
                        child: Icon(!isSecure
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    maxLines: 1,
                    textInputType: TextInputType.name,
                    contentPadding: const EdgeInsets.all(15),
                    controller: password,
                    validate: validatePassword,
                    hintText: Trans.password.trans()),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 200,
                child: GeneralButton(
                    onTap: () async {
                      if (_formKey.currentState?.validate() == true) {
                        await AccountServices.instance.login(
                            password: password.text.trim(),
                            username: username.text.trim());
                      }
                    },
                    text: Trans.login.trans()),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
