import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noob_wallet/Screens/home/components/body.dart';
import 'package:noob_wallet/Screens/login/login.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum TabItem { home, transactionsHistory, news, setting }

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  TabItem _currentItem = TabItem.home;
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.transactionsHistory,
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
          title: 'Wallet',
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
      body: const BodyHome(),
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
      case TabItem.news:
        return Icons.newspaper;
      case TabItem.setting:
        return Icons.settings;
      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return HomeScreen();
      case TabItem.transactionsHistory:
      // return HomeScreen();
      case TabItem.news:
      // return HomeScreen()
      case TabItem.setting:
      // return HomeScreen()
      default:
        return HomeScreen();
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
