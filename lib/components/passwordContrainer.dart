import 'package:flutter/material.dart';
import 'package:noob_wallet/components/colors.dart';

class PasswordContainer extends StatelessWidget {
  const PasswordContainer({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.password,
          color: mainColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 93, 122, 126)),
        ),
      ),
    );
  }
}
