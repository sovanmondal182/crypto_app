import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/widgets/coin_listtile.dart';
import 'package:crypto_app/widgets/favorites_coin_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cryptocurrency coin = Provider.of<Cryptocurrency>(context, listen: false);

    // ThemeProvider theme = Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<CoinsProvider>(
      builder: (context, coinsProvider, child) {
        List<Cryptocurrency> favorites = coinsProvider.coins
            .where((element) => element.isfavorite == true)
            .toList();
        return (favorites.isNotEmpty)
            ? RefreshIndicator(
                onRefresh: () async {
                  await coinsProvider.fetchCoins();
                },
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      // print(index);
                      return CoinListTile(
                        coin: favorites[index],
                      );
                    }),
              )
            : const Center(
                child: Text("No Favorites"),
              );
      },
    );
  }
}
