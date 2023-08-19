// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tandrustito/core/providers/services/auth_methods.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/genera_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Logging in the user w/ Firebase
      await AuthMethods()
          .signUpUser(name: _name, email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: Trans.name.trans()),
                        validator: validateName,
                        onSaved: (input) => _name = input!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: Trans.email.trans()),
                        validator: validateEmail,
                        onSaved: (input) => _email = input!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: Trans.password.trans()),
                        validator: validatePassword,
                        onSaved: (input) => _password = input!,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: GeneralButton(
                        onTap: () {
                          _signUp();
                        },
                        text: Trans.login.trans(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
