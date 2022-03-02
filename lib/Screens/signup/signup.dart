import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noob_wallet/Screens/signup/components/background.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/passwordField.dart';
import 'package:noob_wallet/components/roundedButton.dart';
import 'package:noob_wallet/components/textContainer.dart';
import 'package:noob_wallet/components/inputField.dart';

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
      body: SingleChildScrollView(
        child: Background(
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
                  children: <Widget>[
                    TextContainer(
                      child: InputField(
                        controller: firstNameController,
                        prefixIcon: const Icon(
                          Icons.person_pin,
                          color: lightColor,
                        ),
                        hintText: 'First Name',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                      ),
                    ),
                    TextContainer(
                      child: InputField(
                        controller: secondNameController,
                        prefixIcon: const Icon(
                          Icons.person_pin,
                          color: lightColor,
                        ),
                        hintText: 'Second Name',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Second Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                      ),
                    ),
                    TextContainer(
                      child: InputField(
                        controller: emailController,
                        prefixIcon: const Icon(
                          Icons.person_pin,
                          color: lightColor,
                        ),
                        hintText: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                      ),
                    ),
                    TextContainer(
                      child: PasswordField(
                        controller: passwordController,
                        hintText: 'Password',
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
                      ),
                    ),
                    TextContainer(
                      child: PasswordField(
                        controller: confirmPasswordController,
                        hintText: 'Confirme Password',
                        validator: (value) {
                          if (confirmPasswordController.text !=
                              confirmPasswordController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
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
      ),
    );
  }
}
