import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noob_wallet/Screens/news/components/model.dart';

class APIService {
  static Future<List<NewsModel>> fetchNews() async {
    var uri = Uri.https('crypto-pulse.p.rapidapi.com', '/news');

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "crypto-pulse.p.rapidapi.com",
      "x-rapidapi-key": "f3bc97d720mshdde0ecf209a952fp1fa247jsn4d0f704ec31c",
      "useQueryString": 'true',
    });

    if (response.statusCode == 200) {
      List dataList = [];

      for (var i in jsonDecode(response.body)) {
        dataList.add(i);
      }
      return NewsModel.news(dataList);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
