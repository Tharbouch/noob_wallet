// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:noob_wallet/components/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = mainColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(mainColor),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shadowColor: MaterialStateProperty.all<Color>(
              Colors.blueGrey.withOpacity(0.2)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        ),
        onPressed: () => press(),
      ),
    );
  }
}
