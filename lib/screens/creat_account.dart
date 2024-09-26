import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/auth.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/widgets/input_field.dart';
import 'package:project/models/user.dart';

class CreatAccountScreen extends StatefulWidget {
  const CreatAccountScreen({
    super.key,
    required this.onChangeLanguage,
    required this.signedin,
  });

  final void Function({required bool isSignedin, User user}) signedin;
  final void Function(String selectedLanguage) onChangeLanguage;

  @override
  State<CreatAccountScreen> createState() => _CreatAccountScreenState();
}

class _CreatAccountScreenState extends State<CreatAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = false;
  bool loading = false;
  String? userName;
  String? phoneNum;
  String? password;

  //final url = Uri.parse('http://127.0.0.1:8000/api/register');
  final url = Uri.parse('http://192.168.43.246:8000/api/register');

  void submit() async {
    setState(() {
      loading = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'name': userName, 'phone': '09$phoneNum', 'password': password}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        print(response.body);
        Auth.setToken(data['token']);
        Navigator.of(context).pop();
        setState(() {
          widget.signedin(
            isSignedin: true,
            user: User(
              name: data['new_user']['name'],
              phoneNum: data['new_user']['phone'],
              password: password!,
            ),
          );
        });
        print(response.statusCode);
        _formKey.currentState!.reset();
      } else if (response.statusCode == 302) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).exists,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).somethingWrong,
            ),
          ),
        );
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                'assets/images/create account.png',
                height: double.infinity,
                fit: BoxFit.fitHeight,
              ).image,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).creatAcc,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputField(
                        minLen: 2,
                        text: S.of(context).userName,
                        validate: S.of(context).nameCheck,
                        icon: const Icon(Icons.person),
                        inputType: TextInputType.text,
                        onSaved: (enteredName) {
                          userName = enteredName;
                        },
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
                              icon: Icon(hidePassword
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined),
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
                          onPressed: submit,
                          child: loading
                              ? const CircularProgressIndicator()
                              : Text(
                                  S.of(context).creat,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
