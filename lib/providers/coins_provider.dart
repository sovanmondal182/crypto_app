import 'package:crypto_app/models/cryptocurrency.dart';
import 'package:crypto_app/network/apis.dart';
import 'package:crypto_app/storage/local_storage.dart';
import 'package:flutter/material.dart';

class CoinsProvider with ChangeNotifier {
  bool isLoading = true;
  List<Cryptocurrency> coins = [];

  CoinsProvider() {
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    String currency = await LocalStorage.getCurrency() ?? 'INR';
    List<dynamic> coin = await API.getCoins(currency);
    List<Cryptocurrency> temp = [];

    for (var element in coin) {
      Cryptocurrency newCrypto = Cryptocurrency.fromJson(element);
      temp.add(newCrypto);
    }
    coins = temp;
    isLoading = false;
    notifyListeners();
  }
}
