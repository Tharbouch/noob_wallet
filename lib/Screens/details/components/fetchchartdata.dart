import 'dart:convert';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

class ChartAPI {
  static Future<List<Candle>> fetchChartData(
      {required String id, required String intervale}) async {
    final response = await http.get(Uri.parse(
        'https://api2.binance.com/api/v3/klines?symbol=' +
            id +
            'USDT&interval=' +
            intervale));

    if (response.statusCode == 200) {
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
