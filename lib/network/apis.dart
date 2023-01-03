import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getCoins(String? currency) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currency&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
      var decodedResponse = jsonDecode(response.body);
      List<dynamic> coins = decodedResponse as List<dynamic>;
      return coins;
    } catch (e) {
      return [];
    }
  }

  static Future<List<dynamic>> getMarketChart(
      String? id, String? currency) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=$currency&days=1'));
      var decodedResponse = jsonDecode(response.body);
      List<dynamic> marketChart = decodedResponse['prices'] as List<dynamic>;
      return marketChart;
    } catch (e) {
      return [];
    }
  }
}
