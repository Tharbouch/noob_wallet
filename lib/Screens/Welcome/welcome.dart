import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/Welcome/componets/body.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
