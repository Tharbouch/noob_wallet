import 'package:flutter/material.dart';
import 'package:noob_wallet/components/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const InputField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return (hintText + " cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_pin,
          color: mainColor,
        ),
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
