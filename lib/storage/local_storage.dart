import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveCurrency(String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool currentCurrency =
        await sharedPreferences.setString('currency', currency);
    return currentCurrency;
  }

  static Future<bool> saveCurrencySymbol(String currencySymbol) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool currentCurrencySymbol =
        await sharedPreferences.setString('currencySymbol', currencySymbol);
    return currentCurrencySymbol;
  }

  static Future<String?> getCurrency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currency = sharedPreferences.getString('currency');
    return currency;
  }

  static Future<String?> getCurrencySymbol() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currencySymbol = sharedPreferences.getString('currencySymbol');
    return currencySymbol;
  }

  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool currentTheme = await sharedPreferences.setString('theme', theme);
    return currentTheme;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString('theme');
    return theme;
  }

  static Future<bool> addFavorite(String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    favorites.add(currency);
    bool isAdded =
        await sharedPreferences.setStringList('favorites', favorites);
    return isAdded;
  }

  static Future<bool> removeFavorite(String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    favorites.remove(currency);
    bool isRemoved =
        await sharedPreferences.setStringList('favorites', favorites);
    return isRemoved;
  }

  static Future<List<String>> getFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    return favorites;
  }
}
