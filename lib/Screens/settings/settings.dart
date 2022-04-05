import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/settings/bodysetting.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: ScreenSetting(),
    );
  }
}