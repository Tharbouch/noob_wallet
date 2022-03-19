import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/details/components/fetchchartdata.dart';
import 'package:noob_wallet/Screens/details/components/status.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/roundedButton.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:candlesticks/candlesticks.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  // ignore: no_logic_in_create_state
  State<DetailsScreen> createState() => _DetailsScreenState(text: text);
}

class _DetailsScreenState extends State<DetailsScreen> {
  _DetailsScreenState({required this.text});
  final String text;

  int activeIndex = 0;
  List<Candle> candles = [];
  bool isloading = true;
  String idCoin = '';
  final List<String> chartTimes = ["Today", "1W", "1M", "3M", "6M", "1Y"];
  Future<void> getId() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&sparkline=false'));

    if (response.statusCode == 200) {
      for (var i in jsonDecode(response.body)) {
        if (i['name'] == text) {
          idCoin = i['symbol'].toString().toUpperCase();
        }
      }
      setState(() {
        isloading = false;
      });
    } else {
      throw Exception('Failed to load symbol');
    }
  }

  @override
  void initState() {
    super.initState();
    getId();
    getChartData(id: idCoin);
    Timer.periodic(
        const Duration(seconds: 3), (timer) => getChartData(id: idCoin));
  }

  Future<void> getChartData({required String id}) async {
    candles = await ChartAPI.fetchChartData(id: id);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Status(themeData: themeData),
            const SizedBox(
              height: 30,
            ),
            Container(
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
                  right: 10.0,
                  left: 20.0,
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: chartTimes.map((e) {
                          int currentIndex = chartTimes.indexOf(e);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                activeIndex = currentIndex;
                              });
                            },
                            child: Container(
                              color: currentIndex == activeIndex
                                  ? const Color.fromARGB(255, 218, 237, 253)
                                  : const Color.fromARGB(0, 179, 233, 247),
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 10.0,
                              ),
                              child: Text(
                                e,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 300.0,
                      width: 950.0,
                      child: Candlesticks(
                        candles: candles,
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 40,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Exchange(
                    icon: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 5, 71, 102),
                    ),
                    text: 'Send',
                  ),
                  Exchange(
                    icon: Icon(
                      Icons.call_received,
                      color: Color.fromARGB(255, 5, 71, 102),
                    ),
                    text: 'Withdraw',
                  )
                ]),
          ],
        )),
      ),
    );
  }
}

class Exchange extends StatelessWidget {
  const Exchange({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: icon,
        label: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 5, 71, 102),
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shadowColor: MaterialStateProperty.all<Color>(
              Colors.blueGrey.withOpacity(0.2)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        ),
      ),
    );
  }
}
