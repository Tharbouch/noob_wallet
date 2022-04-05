import 'package:flutter/material.dart';

class Coin {
  Coin({
    @required this.name = '',
    @required this.symbol = '',
    @required this.imageUrl = '',
    @required this.price = 0,
    @required this.change = 0,
    @required this.changePercentage = 0,
  });

  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        name: json['name'],
        imageUrl: json['image'],
        price: json['current_price'],
        changePercentage: json['price_change_percentage_24h_in_currency']);
  }
}

List<Coin> coinList = [];
