import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tandrustito/core/account_services.dart';
import 'package:tandrustito/core/alert/loading_alert.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/genera_button.dart';

class VerifactionCodeScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifactionCodeScreen({super.key, required this.phoneNumber});
  @override
  _VerifactionCodeScreenState createState() => _VerifactionCodeScreenState();
}

class _VerifactionCodeScreenState extends State<VerifactionCodeScreen> {
  late TextEditingController _codeController;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _codeController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  late GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Trans.verficatioCode.trans()),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all((10)),
          // height: MediaQuery.of(context).size.height,
          child: Center(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "${Trans.codeSentTYourPhoneNumber.trans()}\n${widget.phoneNumber}",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: _formKey,
                      child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.blue,
                            primaryColorDark: Colors.black,
                            platform: TargetPlatform.android),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          textAlignVertical: TextAlignVertical.center,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                            handleLogin();
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45.0),
                              borderSide: const BorderSide(
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            contentPadding: const EdgeInsets.all((20)),
                            // fillColor: Colors.white,
                            // filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.0),
                              ),
                            ),
                            hintText: Trans.verficatioCode.trans(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return Trans.required.trans();
                            } else if (value.trim().length != 6) {
                              return "Code Length Must be 6";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GeneralButton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          handleLogin();
                        },
                        text: Trans.checkcode.trans()),
                    const SizedBox(height: 25),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    _handle();
  }

  Future<void> _handle() async {
    if (_formKey.currentState!.validate()) {
      showLoadingProgressAlert();
      PhoneNumberVerifactionServices.i.enterCode(_codeController.text.trim());
    }
  }
}
