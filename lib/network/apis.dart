import 'dart:convert';
import 'package:http/http.dart' as http;

// class API {
// static Future<List<dynamic>> getCoins() async {
//   try {
//     Uri requestPath = Uri.parse(
//         "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
//     // Uri requestPath = Uri.parse("https://api.coincap.io/v2/assets");
//     final response = await http.get(requestPath);
//     var decodedResponse = jsonDecode(response.body);
//     List<dynamic> coins = decodedResponse as List<dynamic>;
//     return coins;
//   } catch (e) {
//     print('error');
//     return [];
//   }
// }
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
}
