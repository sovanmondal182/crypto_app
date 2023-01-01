import 'package:http/http.dart' as http;

class API {
  Future<void> getCoins() async {
    await http.get(Uri.parse('https://api.coincap.io/v2/assets'));
  }
}
