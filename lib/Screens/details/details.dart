import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/details/components/fetchchartdata.dart';
import 'package:noob_wallet/Screens/details/components/status.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/components/colors.dart';
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
  final List<String> chartTimes = [
    "1m",
    "5m",
    "15m",
    "1h",
    "4h",
    "1D",
    "3D",
    "1M"
  ];

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
    candles = await ChartAPI.fetchChartData(
        id: id, intervale: chartTimes[activeIndex]);
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (builder) => const Redirector(),
                ), // redirecting to SignUP page
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
                              print(activeIndex);
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
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Exchange(
                icon: const Icon(
                  Icons.history,
                  color: Color.fromARGB(255, 5, 71, 102),
                ),
                text: 'Predict Price',
                color: Colors.white,
                press: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
