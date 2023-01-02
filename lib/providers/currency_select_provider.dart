import 'package:crypto_app/storage/local_storage.dart';
import "package:flutter/material.dart";

class CurrencySelectProvider with ChangeNotifier {
  bool isLoading = true;
  String? currency;
  String? currencySymbol;

  CurrencySelectProvider() {
    fetchCurrency();
  }

  Future<void> fetchCurrency() async {
    currency = await LocalStorage.getCurrency() ?? 'INR';
    isLoading = false;

    notifyListeners();
  }

  Future<void> fetchCurrencySymbol() async {
    currencySymbol = await LocalStorage.getCurrencySymbol() ?? '₹';
    isLoading = false;

    notifyListeners();
  }

  Future<void> setCurrency(String currency) async {
    this.currency = currency;
    await LocalStorage.saveCurrency(currency);
    notifyListeners();
  }

  Future<void> setCurrencySymbol(String currencySymbol) async {
    this.currencySymbol = currencySymbol;
    await LocalStorage.saveCurrencySymbol(currencySymbol);
    notifyListeners();
  }
}
