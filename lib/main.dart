import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/login/login.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/Screens/welcome/welcome.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        scaffoldBackgroundColor: Color.fromARGB(255, 241, 245, 245),
      ),
      home: const Intro(), //starting the application
    );
  }
}

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with AfterLayoutMixin<Intro> {
  final user = FirebaseAuth.instance.currentUser;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Redirector()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Login()));
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
