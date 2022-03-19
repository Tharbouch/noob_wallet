import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noob_wallet/Screens/details/components/chartmodel.dart';

class ChartAPI {
  static Future<List<ChartModel>> fetchChartData() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=25'));

    if (response.statusCode == 200) {
      List datacChart = [];

      for (var i in jsonDecode(response.body)) {
        i[0] = DateTime.fromMillisecondsSinceEpoch(i[0]);
        print(i[0].runtimeType);
        datacChart.add(i);
      }
      return ChartModel.chartdata(datacChart);
    } else {
      throw Exception('Failed to load chart data');
    }
  }
}
