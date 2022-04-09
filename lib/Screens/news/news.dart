import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/news/components/fetchdata.dart';
import 'package:noob_wallet/Screens/news/components/model.dart';
import 'package:noob_wallet/Screens/news/components/newscard.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> newsData = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  Future<void> getNewsData() async {
    newsData = await APIService.fetchNews();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(children: <Widget>[
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsData.length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                        titel: newsData[index].title,
                        description: newsData[index].description,
                        imageUrl: newsData[index].images,
                        link: newsData[index].link,
                      );
                    }),
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
