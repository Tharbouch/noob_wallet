import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/details/components/chartmodel.dart';
import 'package:noob_wallet/Screens/details/components/fetchchartdata.dart';
import 'package:noob_wallet/Screens/details/components/status.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';

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
  //int activeIndex = 0;

  List<ChartModel> chartdata = [];
  bool isloading = true;

  //final List<String> chartTimes = ["Today", "1W", "1M", "3M", "6M", "1Y"];

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Future<void> getChartData() async {
    chartdata = await ChartAPI.fetchChartData();
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
            Column(),
          ],
        )),
      ),
    );
  }
}
