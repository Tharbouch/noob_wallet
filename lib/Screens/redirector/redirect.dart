import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/home/home.dart';
import 'package:noob_wallet/Screens/login/login.dart';
import 'package:noob_wallet/Screens/news/news.dart';
//import 'package:noob_wallet/Screens/prediction/prediction_dash.dart';
import 'package:noob_wallet/Screens/settings/settings.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Redirector extends StatefulWidget {
  const Redirector({Key? key}) : super(key: key);

  @override
  State<Redirector> createState() => _RedirectorState();
}

enum TabItem { home, transactionsHistory, prediction, news, setting }

class _RedirectorState extends State<Redirector> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String text = '';

  TabItem _currentItem = TabItem.home;
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.transactionsHistory,
    TabItem.prediction,
    TabItem.news,
    TabItem.setting
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SafeArea(
            child: appBar(
          left: IconButton(
            icon: const Icon(
              Icons.person,
              color: mainColor,
              size: 28,
            ),
            onPressed: () {},
          ),
          title: _titel(_currentItem),
          right: IconButton(
            icon: const Icon(
              Icons.logout,
              color: mainColor,
              size: 28,
            ),
            onPressed: () {
              signOut();
            },
          ),
        )),
      ),
      body: _buildScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomTabs
            .map((tabItem) => _bottomNavigationBarItem(_icon(tabItem), tabItem))
            .toList(),
        onTap: _onSelectTab,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      IconData icon, TabItem tabItem) {
    final Color color = _currentItem == tabItem ? mainColor : lightColor;

    return BottomNavigationBarItem(icon: Icon(icon, color: color), label: '');
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];

    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.account_balance_wallet;
      case TabItem.transactionsHistory:
        return Icons.history;
      case TabItem.prediction:
        return Icons.analytics;
      case TabItem.news:
        return Icons.newspaper;
      case TabItem.setting:
        return Icons.settings;

      default:
        throw 'Unknown $item';
    }
  }

  String _titel(TabItem item) {
    switch (item) {
      case TabItem.home:
        return 'Wallet';
      case TabItem.transactionsHistory:
        return 'Transactions';
      case TabItem.prediction:
        return "Prediction";
      case TabItem.news:
        return "News";
      case TabItem.setting:
        return "Settings";
      default:
        return '';
    }
  }

  Widget? _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return const HomeScreen();
      case TabItem.transactionsHistory:
      // return HomeScreen();
      case TabItem.prediction:
      //return Prediction();
      case TabItem.news:
        return const NewsScreen();
      // return HomeScreen()
      case TabItem.setting:
        return const SettingScreen();
      default:
    }
  }

  void signOut() async {
    try {
      await _auth.signOut().then(
            (uid) => {
              Fluttertoast.showToast(msg: "signOut Successful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login())),
            },
          );
    } catch (e) {
      print(e);
    }
  }
}
