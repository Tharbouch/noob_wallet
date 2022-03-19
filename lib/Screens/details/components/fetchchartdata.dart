import 'dart:convert';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

class ChartAPI {
  static Future<List<Candle>> fetchChartData() async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1m'));

    if (response.statusCode == 200) {
      List<Candle> datacChart = [];
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => Candle.fromJson(e))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Failed to load chart data');
    }
  }
}
