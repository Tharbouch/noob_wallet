import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noob_wallet/Screens/login/components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noob_wallet/Screens/signup/signup.dart';
import 'package:noob_wallet/Screens/welcome/welcome.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/emailContainer.dart';
import 'package:noob_wallet/components/passwordContrainer.dart';
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextContainer(
                    child: EmailContainer(
                      emailController: emailController,
                    ),
                  ),
                  TextContainer(
                    child: PasswordContainer(
                        passwordController: passwordController),
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
              (uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreen())),
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