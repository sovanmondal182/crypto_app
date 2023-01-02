import 'dart:async';

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
    List<dynamic> favorites = await LocalStorage.getFavorites();
    List<dynamic> coin = await API.getCoins(currency);
    List<Cryptocurrency> temp = [];

    for (var element in coin) {
      Cryptocurrency newCrypto = Cryptocurrency.fromJson(element);
      if (favorites.contains(newCrypto.id)) {
        newCrypto.isfavorite = true;
      }
      temp.add(newCrypto);
    }
    coins = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 5), () {
      fetchCoins();
    });
  }

  void addfavorites(Cryptocurrency coin) async {
    int index = coins.indexOf(coin);
    coins[index].isfavorite = true;
    await LocalStorage.addFavorite(coin.id!);

    notifyListeners();
  }

  void removefavorites(Cryptocurrency coin) async {
    int index = coins.indexOf(coin);
    coins[index].isfavorite = false;
    await LocalStorage.removeFavorite(coin.id!);

    notifyListeners();
  }
}
