import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noob_wallet/Screens/signup/components/background.dart';
import 'package:noob_wallet/components/emailContainer.dart';
import 'package:noob_wallet/components/passwordContrainer.dart';
import 'package:noob_wallet/components/roundedButton.dart';
import 'package:noob_wallet/components/textContainer.dart';
import 'package:noob_wallet/components/textField.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SignUp",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.2,
            ),
            const SizedBox(
              height: 4,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextContainer(
                    child: InputField(
                      controller: firstNameController,
                      hintText: 'First Name',
                    ),
                  ),
                  TextContainer(
                    child: InputField(
                      controller: secondNameController,
                      hintText: 'Second Name',
                    ),
                  ),
                  TextContainer(
                    child: EmailContainer(
                      emailController: emailController,
                    ),
                  ),
                  TextContainer(
                    child: PasswordContainer(
                        passwordController: passwordController),
                  ),
                  TextContainer(
                    child: PasswordContainer(
                      passwordController: passwordController,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundedButton(
                    text: 'SignUp',
                    press: () {
                      //signIn(emailController.text, passwordController.text);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
