import 'package:crypto_app/storage/local_storage.dart';
import "package:flutter/material.dart";

class CurrencySelectProvider with ChangeNotifier {
  bool isLoading = true;
  String? currency;

  CurrencySelectProvider() {
    getCurrency();
  }

  Future<void> getCurrency() async {
    currency = await LocalStorage.getCurrency() ?? 'INR';
    isLoading = false;

    notifyListeners();
  }

  void setCurrency(String currency) {
    this.currency = currency;
    LocalStorage.saveCurrency(currency);
    notifyListeners();
  }
}
