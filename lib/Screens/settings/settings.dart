import 'package:flutter/material.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:noob_wallet/components/manageTheme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = ThemeManager().getDark();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 125,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 20, 10),
            child: Column(
              children: [
                card(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 241, 241),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 50,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.brightness_medium),
                          ),
                        ),
                      ),
                      const Text("Dark Mode"),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                          ThemeManager().setDark(isSwitched);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: card(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 241, 241),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 50,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.help),
                            ),
                          ),
                        ),
                        const Text("Help Centre"),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Openmail()));
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: card(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 241, 241),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 50,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.question_mark),
                            ),
                          ),
                        ),
                        const Text("About"),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenAbout()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Openmail extends StatelessWidget {
  const Openmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Mail App Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  """It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. """),
            ),
            ElevatedButton(
              child: const Text('Open gmail'),
              onPressed: () async {
                EmailContent email = EmailContent(
                  to: [
                    'user@domain.com',
                  ],
                  subject: 'Hello!',
                  body: 'How are you doing?',
                  cc: ['user2@domain.com', 'user3@domain.com'],
                  bcc: ['boss@domain.com'],
                );

                OpenMailAppResult result =
                    await OpenMailApp.composeNewEmailInMailApp(
                        nativePickerTitle: 'Select email app to compose',
                        emailContent: email);
                if (!result.didOpen && !result.canOpen) {
                  showNoMailAppsDialog(context);
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) => MailAppPickerDialog(
                      mailApps: result.options,
                      emailContent: email,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hd"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. "),
        ],
      ),
    );
  }
}
