import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noob_wallet/Screens/home/home.dart';
import 'package:noob_wallet/Screens/login/components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noob_wallet/Screens/signup/signup.dart';
import 'package:noob_wallet/Screens/welcome/welcome.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/inputField.dart';
import 'package:noob_wallet/components/passwordField.dart';
import 'package:noob_wallet/components/roundedButton.dart';
import 'package:noob_wallet/components/textContainer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

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
              "Welcome Back",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.25,
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
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
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    text: 'Login',
                    press: () {
                      signIn(emailController.text, passwordController.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't you have an account?",
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: lightColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: navigateToSignUp,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigateToSignUp() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => SignUp()),
      (route) => false,
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
              (uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => HomeScreen()),
                  (route) => false,
                ),
              },
            );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
