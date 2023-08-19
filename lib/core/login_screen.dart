// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tandrustito/core/providers/services/auth_methods.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/core/signup_screen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/genera_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _logInUser() async {
    if (_key.currentState?.validate() != true) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    await AuthMethods().logInUser(
      email: _emailIdController.text,
      password: _passwordController.text,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _userIDEditContainer() {
    return GeneralTextFiled(
      controller: _emailIdController,
      viewBorder: true,
      fillColor: Colors.transparent,
      validate: validateEmail,
      hintText: Trans.email.trans(),
    );
  }

  Widget _passwordEditContainer() {
    return GeneralTextFiled(
      controller: _passwordController,
      obscureText: true,
      viewBorder: true,
      fillColor: Colors.transparent,
      validate: validatePassword,
      hintText: Trans.password.trans(),
    );
  }

  Widget _loginContainer() {
    return GeneralButton(
      onTap: _logInUser,
      text: Trans.login.trans(),
    );
  }

  Widget _bottomBar() {
    return Container(
      alignment: Alignment.center,
      height: 49.5,
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen())),
                        child: Text(Trans.signUp.trans()),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _userIDEditContainer(),
              const SizedBox(height: 20),
              _passwordEditContainer(),
              const SizedBox(height: 20),
              _loginContainer(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 2.7,
                    color: Colors.grey,
                    child: const ListTile(),
                  ),
                  const Text(
                    ' OR',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 2.7,
                    color: Colors.grey,
                  ),
                ],
              ),
              _bottomBar()
            ],
          ),
        ),
      ),
    );
  }
}
