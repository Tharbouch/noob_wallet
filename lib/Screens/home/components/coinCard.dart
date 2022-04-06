import 'package:flutter/material.dart';
import 'dart:math';
import 'package:noob_wallet/Screens/details/details.dart';

class CoinCard extends StatefulWidget {
  CoinCard({
    @required this.name = '',
    @required this.imageUrl = '',
    @required this.price = 0,
    @required this.changePercentage = 0,
  });

  String name;
  String imageUrl;
  double price;
  num changePercentage;

  @override
  State<CoinCard> createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: GestureDetector(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
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
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(widget.imageUrl),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.price.toDouble().toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        double.parse((widget.changePercentage)
                                    .toStringAsFixed(2)) <
                                0
                            ? (widget.changePercentage)
                                    .toStringAsFixed(2)
                                    .toString() +
                                '%'
                            : '+' +
                                (widget.changePercentage)
                                    .toStringAsFixed(2)
                                    .toString() +
                                '%',
                        style: TextStyle(
                          color: widget.changePercentage.toDouble() < 0
                              ? Colors.red[400]
                              : Colors.greenAccent[400],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => DetailsScreen(
                        text: widget.name,
                        price: widget.price.toDouble().toString(),
                        priceChange: widget.changePercentage,
                      )), // redirecting to SignUP page
            );
          },
        ));
  }
}
