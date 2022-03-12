import 'package:flutter/material.dart';
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
            '$title',
            style: TextStyle(
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
