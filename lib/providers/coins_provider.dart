import 'dart:async';

import 'package:coinup/models/crypto_currency.dart';
import 'package:coinup/network/apis.dart';
import 'package:coinup/storage/local_storage.dart';
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
    Timer(const Duration(seconds: 10), () {
      fetchCoins();
    });
  }

  Cryptocurrency fetchCoinsdByID(String id) {
    Cryptocurrency coin = coins.firstWhere((element) => element.id == id);
    return coin;
  }

  Future<void> addfavorites(Cryptocurrency coin) async {
    coins[coin.marketcaprank! - 1].isfavorite = true;
    await LocalStorage.addFavorite(coin.id!);
    notifyListeners();
  }

  Future<void> removefavorites(Cryptocurrency coin) async {
    coins[coin.marketcaprank! - 1].isfavorite = false;
    await LocalStorage.removeFavorite(coin.id!);
    notifyListeners();
  }

  Future<List<dynamic>> fetchChartData(String id) async {
    try {
      List<dynamic> marketChart1 = await API.getMarketChart(id, currency, '1');
      List<dynamic> marketChart7 = await API.getMarketChart(id, currency, '7');
      List<dynamic> marketChart30 =
          await API.getMarketChart(id, currency, '30');
      List<dynamic> marketChart365 =
          await API.getMarketChart(id, currency, '365');
      List<dynamic> marketChartmax =
          await API.getMarketChart(id, currency, '1825');
      isLoading = false;
      return [
        marketChart1,
        marketChart7,
        marketChart30,
        marketChart365,
        marketChartmax
      ];
    } catch (e) {
      return [];
    }
  }
}
