import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/auth.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/screens/creat_account.dart';
import 'package:project/widgets/input_field.dart';
import 'package:project/widgets/main_container.dart';
import 'package:project/models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onChangeLanguage,
    required this.signedin,
  });

  final void Function({required bool isSignedin, User user}) signedin;
  final void Function(String selectedLanguage) onChangeLanguage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final url = Uri.parse('http://192.168.43.246:8000/api/login');
  //final url = Uri.parse('http://127.0.0.1:8000/api/login');

  bool hidePassword = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? phoneNum;
    String? password;

    return MainContainer(
      title: S.of(context).login,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
              minLen: 8,
              text: S.of(context).phone,
              validate: S.of(context).phoneValidate,
              icon: const Icon(Icons.phone_android),
              inputType: TextInputType.number,
              onSaved: (enteredNum) {
                phoneNum = enteredNum;
              },
              obscureText: false,
              maxLength: 8,
            ),
            const SizedBox(
              height: 16,
            ),
            Stack(
              children: [
                InputField(
                  minLen: 8,
                  text: S.of(context).password,
                  validate: S.of(context).passwordValidate,
                  icon: const Icon(Icons.vpn_key_outlined),
                  inputType: TextInputType.text,
                  onSaved: (enterdPassword) {
                    password = enterdPassword;
                  },
                  obscureText: hidePassword,
                ),
                Positioned(
                  right: Intl.getCurrentLocale() == 'en' ? 5 : null,
                  left: Intl.getCurrentLocale() == 'en' ? null : 5,
                  top: 6,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: const ButtonStyle().copyWith(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final response = await http.post(
                      url,
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode(
                        {
                          'phone': '09$phoneNum',
                          'password': password,
                          'user_type': 'user',
                        },
                      ),
                    );
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      final data = json.decode(response.body);
                      print(response.body);
                      Auth.setToken(data['token']);
                      print(Auth.token);
                      setState(() {
                        widget.signedin(
                          isSignedin: true,
                          user: User(
                            name: data['user']['name'],
                            phoneNum: data['user']['phone'],
                            password: password!,
                          ),
                        );
                      });
                      _formKey.currentState!.reset();
                    } else {
                      /*setState(() {
                        widget.signedin(
                          isSignedin: true,
                          user:const  User(
                            name: 'MHD',
                            phoneNum: '0911111111',
                            password: '1111111111',
                          ),
                        );
                      });*/
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).somethingWrong,
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S.of(context).wrongInput,
                        ),
                      ),
                    );
                  }
                  setState(() {
                    loading = false;
                  });
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        S.of(context).loginButton,
                      ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).noAccount,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreatAccountScreen(
                            signedin: widget.signedin,
                            onChangeLanguage: widget.onChangeLanguage),
                      ),
                    );
                  },
                  child: Text(
                    S.of(context).creat,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
