import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noob_wallet/Screens/signup/signup.dart';
import 'package:noob_wallet/Screens/welcome/components/background.dart';
import 'package:noob_wallet/components/roundedButton.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // building the body of the screen
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome to Noob Wallet",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: size.height * 0.42,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: 'Get Started',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
