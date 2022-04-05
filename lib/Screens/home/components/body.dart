import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:noob_wallet/Screens/home/components/coinCard.dart';
import 'package:noob_wallet/Screens/home/components/coinModel.dart';
import 'package:noob_wallet/Screens/tt/b.dart';
import 'package:noob_wallet/Screens/wallet/initwallet.dart';
import 'package:noob_wallet/components/colors.dart';
import 'package:noob_wallet/components/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_cloudstore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web3dart/web3dart.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  final qrKey = GlobalKey();
  late EthereumAddress pubaddress;
  String adress = 'None';
  String pvadress = 'None';
  String rpcUrl = 'http://192.168.0.154:7545';
  dynamic balance = 0.00;
  late Web3Client client;
  final reciverAddress = TextEditingController();
  final getamount = TextEditingController();
  final sentAmount = 0;

  @override
  void initState() {
    super.initState();
    fetchCoin();
    //hena lwe9t bash idir reload l data men daq api
    client = Web3Client('http://192.168.0.154:7545', Client());
    walletAdrees();
    Timer.periodic(const Duration(seconds: 2), (timer) => fetchCoin());
  }

  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    // hena kayn api menin kanjibo data

    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2Cethereum%2Csolana%2Cripple&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      var size = values.length;
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        if (mounted) {
          setState(() {
            coinList;
          });
        }
      }
      coinList = coinList.sublist(0, size);
      return coinList;
    } else {
      Fluttertoast.showToast(msg: 'Failed to load coins');
      throw Exception('Failed to load coins');
    }
  }

  walletAdrees() async {
    dynamic userdata = await getUserDetails();
    if (userdata != null) {
      setState(() {
        adress = userdata['publicAdress'];
        pvadress = userdata['privateAdress'];
        final credentials = EthPrivateKey.fromHex(pvadress);
        pubaddress = credentials.address;
        getBalance(pubaddress);
      });
    }
  }

  Future<DeployedContract> loadContract() async {
    String contractAddress = "0xD2477b20A178b2Abb2eaf3Cd0C55E965b4A0De91";
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "MetaCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final data = await client.call(
        contract: contract, function: ethFunction, params: args);
    return data;
  }

  Future<void> getBalance(EthereumAddress credentialAddress) async {
    List<dynamic> result = await query("getBalance", [credentialAddress]);
    var data = result[0];
    setState(() {
      balance = data;
    });
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(pvadress);
    DeployedContract contract = await loadContract();

    final ethFunction = contract.function(functionName);

    var result = await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
    );
    print(result);
    return result;
  }

  Future<String> sendCoind(String targetAddressHex, int amount) async {
    EthereumAddress addressReciver = EthereumAddress.fromHex(targetAddressHex);
    // sendCoin transaction
    var bigAmount = BigInt.from(amount);
    var response = await submit("sendCoin", [addressReciver, bigAmount]);
    // hash of the transaction
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 20, 10),
                child: card(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          ClipOval(
                            child: Material(
                              color: mainColor,
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 35),
                          Expanded(
                            child: Text('Total Wallet Balance',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 59))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            balance.toString() + ' ETH',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: lightColor),
                          ),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const InitWallet(),
                  ), // redirecting to SignUP page
                );
              },
            )
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Exchange(
              icon: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 5, 71, 102),
              ),
              text: 'Send',
              color: Colors.white,
              press: () {
                showSend(context);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Exchange(
              icon: const Icon(
                Icons.call_received,
                color: Color.fromARGB(255, 5, 71, 102),
              ),
              text: 'Desposit',
              color: Colors.white,
              press: () {
                showDeposit(context, qrKey, adress.toString());
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: coinList.length,
                    itemBuilder: (context, index) {
                      return CoinCard(
                        name: coinList[index].name,
                        imageUrl: coinList[index].imageUrl,
                        price: coinList[index].price.toDouble(),
                        changePercentage:
                            coinList[index].changePercentage.toDouble(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showDeposit(BuildContext context, dynamic qrKey, String adress) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Container(
          height: 500,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              children: [
                RepaintBoundary(
                  key: qrKey,
                  child: QrImage(
                    data: adress, //This is the part we give data to our QR
                    //  embeddedImage: , You can add your custom image to the center of your QR
                    semanticsLabel:
                        'You Public Adress', //You can add some info to display when your QR scanned
                    size: 250,
                    backgroundColor: Colors.white,
                    version: QrVersions.auto, //You can also give other versions
                  ),
                ),
                const SizedBox(height: 45),
                const Text(
                  "Wallet Adress",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    Container(
                      height: 40,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          adress,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Clipboard.setData(ClipboardData(text: adress)).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copied to Clipboard.'),
                                    ),
                                  ));
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.black,
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  void showSend(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Container(
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              const Text(
                "Send ETH",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Wallet Adress",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 280,
                          height: 80,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Long press to past',
                              border: OutlineInputBorder(),
                            ),
                            controller: reciverAddress,
                            onSaved: (value) {
                              reciverAddress.text = value!;
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 30,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "ETH Amount",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 280,
                          height: 80,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                            controller: getamount,
                            onSaved: (value) {
                              getamount.text = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Exchange(
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 5, 71, 102),
                ),
                text: 'Send',
                color: const Color.fromARGB(255, 250, 245, 245),
                press: () {
                  sendCoind(reciverAddress.text, int.parse(getamount.text));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> getUserDetails() async {
    dynamic data;
    var userInstance = FirebaseAuth.instance.currentUser;
    final firebase_cloudstore.DocumentReference document = firebase_cloudstore
        .FirebaseFirestore.instance
        .collection("users")
        .doc(userInstance!.uid);
    await document
        .get()
        .then<dynamic>((firebase_cloudstore.DocumentSnapshot snapshot) {
      data = snapshot.data();
    });
    return data;
  }
}
