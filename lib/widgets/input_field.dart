import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/generated/l10n.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.minLen,
    required this.text,
    required this.validate,
    required this.icon,
    required this.onSaved,
    required this.inputType,
    super.key,
    required this.obscureText,
    this.maxLength,
  });

  final int minLen;
  final String validate;
  final String text;
  final Icon icon;
  final TextInputType inputType;
  final void Function(String? phoneNum) onSaved;
  final bool obscureText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primaryContainer,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: inputType,
        maxLength: maxLength,
        //initialValue: text == S.of(context).phone ? '09' : null,
        inputFormatters: inputType == TextInputType.number
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(
          prefix: text == S.of(context).phone
              ? Text(
                  '09',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : null,
          label: Text(text),
          labelStyle: const TextStyle().copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          prefixIcon: icon,
          prefixIconColor: Theme.of(context).colorScheme.primary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.inversePrimary,
          floatingLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorStyle: const TextStyle().copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.trim().length < minLen) {
            return validate;
          }
          return null;
        },
        onSaved: (enteredNUm) => onSaved(enteredNUm),
      ),
    );
  }
}
