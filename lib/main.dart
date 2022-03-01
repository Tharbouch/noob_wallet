import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/welcome/welcome.dart';
import 'package:noob_wallet/components/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noob Wallet',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: mainColor,
        scaffoldBackgroundColor: const Color(0xFFf4f5f5),
      ),
      home: const WelcomeScreen(),
    );
  }
}
