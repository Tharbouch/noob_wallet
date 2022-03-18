import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noob_wallet/Screens/login/login.dart';
import 'package:noob_wallet/Screens/signup/components/background.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/model.dart';
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
  //setting up input variables and firebase environment
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ///

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
                height: size.height * 0.15,
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
                          Icons.email_outlined,
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
                        signUp(emailController.text, passwordController.text);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: lightColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: navigateToLogIn,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //add new user information to firebase store ,setting up log in info and cheking the given informations

  //info cheking and setting up log in info
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
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

  navigateToLogIn() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  //add new user information to firebase store
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = secondNameController.text;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => navigateToLogIn()),
      (route) => false,
    );
  }
}
