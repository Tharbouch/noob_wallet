import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/home/home.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SafeArea(
            child: appBar(
          left: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: mainColor,
              size: 28,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => const Redirector(),
                ), // redirecting to SignUP page
                (route) => false,
              );
            },
          ),
          title: text,
          right: const SizedBox(
            width: 28,
          ),
        )),
      ),
    );
  }
}
