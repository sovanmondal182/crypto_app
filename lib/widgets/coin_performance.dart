import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinPerformance extends StatelessWidget {
  final Cryptocurrency coin;
  const CoinPerformance({Key? key, required this.coin}) : super(key: key);

  Widget coinPerformancew(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget space() {
    return const Divider(
      thickness: 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    CoinsProvider coinsProvider =
        Provider.of<CoinsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coin Performance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        coinPerformancew('Market Cap',
            "${coinsProvider.symbol} ${coin.marketcap!.toStringAsFixed(4)}"),
        space(),
        coinPerformancew('Volume',
            "${coinsProvider.symbol} ${coin.totalvolume!.toStringAsFixed(4)}"),
        space(),
        coinPerformancew('Circulating Supply',
            "${coin.circulatingsupply!.toInt().toString()} ${coin.symbol!.toUpperCase()}"),
        space(),
        coinPerformancew('24H High',
            "${coinsProvider.symbol} ${coin.high_24h!.toStringAsFixed(4)}"),
        space(),
        coinPerformancew('24H Low',
            "${coinsProvider.symbol} ${coin.low_24h!.toStringAsFixed(4)}"),
        space(),
        coinPerformancew('All Time High',
            "${coinsProvider.symbol} ${coin.ath!.toStringAsFixed(4)}"),
        space(),
        coinPerformancew('All Time Low',
            "${coinsProvider.symbol} ${coin.atl!.toStringAsFixed(4)}"),
      ],
    );
  }
}
