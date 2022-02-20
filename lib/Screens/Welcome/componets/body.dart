import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noob_wallet/Screens/Welcome/componets/background.dart';

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
              "welcome",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: size.height * 0.45,
            ),
          ],
        ),
      ),
    );
  }
}
