import 'package:flutter/material.dart';

import 'package:project/generated/l10n.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({
    required this.onChangeLanguage,
    super.key,
  });

  final void Function(String selectedLanguage) onChangeLanguage;

  @override
  State<ChooseLanguageScreen> createState() {
    return _ChooseLanguageScreenState();
  }
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chooseLan),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              S.of(context).english,
              style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              setState(() {
                widget.onChangeLanguage('en');
              });
            },
          ),
          ListTile(
            title: Text(
              S.of(context).arabic,
              style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              setState(() {
                widget.onChangeLanguage('ar');
              });
            },
          ),
        ],
      ),
    );
  }
}
