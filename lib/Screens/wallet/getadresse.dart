import 'package:cloud_firestore/cloud_firestore.dart';

class WalletAddressService {
  static Future<List<dynamic>?> getData() async {
    List<dynamic> items = [];

    try {
      await FirebaseFirestore.instance
          .collection('adresses')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          items.add(doc);
        }
      });
      return items;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
