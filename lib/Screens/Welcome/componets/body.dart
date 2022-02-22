import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noob_wallet/Screens/Welcome/componets/background.dart';
import 'package:noob_wallet/components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome To Noob Wallet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.02),
            RoundedButton(
              text: "Get Started",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
