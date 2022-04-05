import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/redirector/redirect.dart';
import 'package:noob_wallet/Screens/wallet/getadresse.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitWallet extends StatefulWidget {
  const InitWallet({Key? key}) : super(key: key);

  @override
  State<InitWallet> createState() => _InitWalletState();
}

class _InitWalletState extends State<InitWallet> {
  String? public;
  String? private;
  String? username;
  int id = 0;
  int selected = 0;
  List data = [];

  check() async {
    dynamic userdata = await getUserDetails();
    print(userdata);
    if (userdata != null) {
      setState(() {
        public = userdata['publicAdress'];
        private = userdata['privateAdress'];
        username = userdata['uid'];
        id = userdata["id"];
        bool created = userdata['walletCreated'];
        created == true ? selected = 1 : selected = 0;
      });
      print(selected);
    } else {
      selected = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
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
          title: 'Wallet Addresses',
          right: const SizedBox(),
        )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          if (selected == 0)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 30.0,
                top: 20.0,
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Add a Wallet"),
                  ),
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Icon(Icons.add),
                        onPressed: () async {
                          setState(() {
                            selected = 1;
                          });
                          data = await WalletAddressService.getData() as List;
                          public = data[id]['public'];
                          private = data[id]['private'];
                          updateUserDetails(private, public);
                        },
                      ))
                ],
              ),
            )
          else
            Column(
              children: [
                Center(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 0, 190, 48),
                  child: const Text(
                    "Successfully initiated wallet!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )),
                const Center(
                  child: Text(
                    "Wallet Private Address :",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    private.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Do not reveal your private address to anyone!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ),
                const Divider(),
                const Center(
                  child: Text(
                    "Wallet Public Address : ",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    public.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                const Center(
                  child: Text(
                    "Go back to main page!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Future<dynamic> getUserDetails() async {
    dynamic data;
    var userInstance = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(userInstance!.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) {
      data = snapshot.data();
    });
    return data;
  }

  Future<void> updateUserDetails(private, public) async {
    var userInstance = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(userInstance!.uid);
    await document
        .update({
          'privateAdress': private.toString(),
          'publicAdress': public.toString(),
          'walletCreated': true
        })
        .whenComplete(() => {print("executed")})
        .catchError((error) {
          print(error.toString());
        });
  }
}
