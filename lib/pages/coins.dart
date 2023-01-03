import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/widgets/coin_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<Coins> createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(builder: (context, coinsProvider, child) {
      if (coinsProvider.isLoading == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (coinsProvider.coins.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: coinsProvider.coins.length,
            itemBuilder: (context, index) {
              return CoinListTile(coin: coinsProvider.coins[index]);
            },
          );
        } else {
          return const Text("No Data Found");
        }
      }
    });
  }
}
