import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noob_wallet/Screens/home/components/coinCard.dart';
import 'package:noob_wallet/Screens/home/components/coinModel.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    bool isloading = true;
    // hena kayn api menin kanjibo data

    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2Cethereum%2Csolana%2Cripple&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      var size = values.length;
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        if (mounted) {
          setState(() {
            coinList;
          });
        }
      }
      coinList = coinList.sublist(0, size);
      return coinList;
    } else {
      print(coinList);
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    //hena lwe9t bash idir reload l data men daq api
    Timer.periodic(const Duration(seconds: 3), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            const SizedBox(
              width: 20,
            ),
            Balance(context: context, total: '\$39.589'),
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: coinList.length,
                    itemBuilder: (context, index) {
                      return CoinCard(
                        name: coinList[index].name,
                        imageUrl: coinList[index].imageUrl,
                        price: coinList[index].price.toDouble(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
