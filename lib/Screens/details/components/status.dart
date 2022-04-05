import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 30.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1 BTC / USD",
                style: themeData.textTheme.caption,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                "\$47,043.28",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 26.0,
                ),
              ),
              Text(
                "-1.51%",
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Volume 24h USD",
                style: themeData.textTheme.caption,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                "\$31,771,866,277",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 26.0,
                ),
              ),
              Text(
                "+16.80%",
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 16.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
