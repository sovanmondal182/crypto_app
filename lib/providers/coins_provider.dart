import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/network/apis.dart';
import 'package:crypto_app/storage/local_storage.dart';
import 'package:flutter/material.dart';

class CoinsProvider with ChangeNotifier {
  bool isLoading = true;
  List<Cryptocurrency> coins = [];
  late String currency;
  late String symbol;

  CoinsProvider() {
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    currency = await LocalStorage.getCurrency() ?? 'INR';
    symbol = await LocalStorage.getCurrencySymbol() ?? '₹';
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
