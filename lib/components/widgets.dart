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
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: child,
  );
}

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.context,
    required this.total,
  }) : super(key: key);

  final BuildContext context;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 20, 0),
      child: card(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Material(
                    color: mainColor,
                    child: InkWell(
                      splashColor: Colors.red, // inkwell color
                      child: const SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 25.0,
                          )),
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(width: 35),
                const Expanded(
                  child: Text('Total Wallet Balance',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 10, 59))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  total,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: lightColor),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
