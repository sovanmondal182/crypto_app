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

  void setCurrency(String currency) {
    this.currency = currency;
    LocalStorage.saveCurrency(currency);
    notifyListeners();
  }

  void setCurrencySymbol(String currencySymbol) {
    this.currencySymbol = currencySymbol;
    LocalStorage.saveCurrencySymbol(currencySymbol);
    notifyListeners();
  }
}
