import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Trans {
  String privateKey =
      '26904359d24c4fe12718148d3038df0a1482db608c2e68aec34536c24a10a54c';
  String rpcUrl = 'http://192.168.0.154:7545';
  var balance;

  Future<void> main() async {
    // start a client we can use to send transactions
    final client = Web3Client(rpcUrl, Client());

    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = credentials.address;

    // ignore: avoid_print

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
      print(result[0]);
    }

    getBalance(address);
    Future<String> submit(String functionName, List<dynamic> args) async {
      EthPrivateKey credentials = EthPrivateKey.fromHex(
          "79f9c62eb002d94a6d8a43f313e74c55bf78483efe7e1f210152642ebe44c09c");

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
      EthereumAddress address = EthereumAddress.fromHex(targetAddressHex);
      // uint in smart contract means BigInt for us
      var bigAmount = BigInt.from(amount);
      // sendCoin transaction
      var response = await submit("sendCoin", [address, bigAmount]);
      // hash of the transaction
      return response;
    }

    sendCoind('0xc955dab3e115075d1467661e4eC294188CB2Bc82', 5);
    await client.dispose();
  }
}
