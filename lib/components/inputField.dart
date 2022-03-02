import 'package:flutter/material.dart';
import 'package:noob_wallet/components/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget prefixIcon;
  final String hintText;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      onSaved: (value) {
        controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightColor),
        ),
        border: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 93, 122, 126)),
        ),
      ),
    );
  }
}
