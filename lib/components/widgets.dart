import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/wallet/initwallet.dart';
import 'package:noob_wallet/components/colors.dart';

Widget appBar(
    {required Widget left, required String title, required Widget right}) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          Text(
            title,
            style: const TextStyle(
              color: mainColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          right,
        ],
      ),
    ),
  );
}

Widget card({
  double width = double.infinity,
  double padding = 20,
  required Widget child,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(padding),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 228, 226, 226),
          offset: Offset(4, 4),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Color.fromARGB(255, 228, 226, 226),
          offset: Offset(-4, -4),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: child,
  );
}

class Exchange extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function press;
  final Color color;
  const Exchange(
      {Key? key,
      required this.text,
      required this.icon,
      required this.press,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 5, 71, 102),
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shadowColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 13, 36, 47).withOpacity(1)),
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
