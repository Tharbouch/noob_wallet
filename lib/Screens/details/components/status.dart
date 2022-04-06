import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.themeData,
    required this.change,
    required this.idCoin,
    required this.price,
  }) : super(key: key);

  final ThemeData themeData;
  final String idCoin;
  final num change;
  final String price;

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
                "1" + idCoin + "/ USD",
                style: themeData.textTheme.caption,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                price,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 26.0,
                ),
              ),
              Text(
                double.parse((change).toStringAsFixed(2)) < 0
                    ? (change).toStringAsFixed(2).toString() + '%'
                    : '+' + (change).toStringAsFixed(2).toString() + '%',
                style: TextStyle(
                  color: change.toDouble() < 0
                      ? Colors.red[400]
                      : Colors.greenAccent[400],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
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
