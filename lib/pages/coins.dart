import 'package:crypto_app/providers/coins_provider.dart';
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
          return RefreshIndicator(
              onRefresh: () async {
                await coinsProvider.fetchCoins();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: coinsProvider.coins.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(coinsProvider.coins[index].name!),
                    leading: coinsProvider.coins[index].image == null
                        ? Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        coinsProvider.coins[index].image!))),
                          ),
                    subtitle: Text(coinsProvider.coins[index].symbol!),
                    trailing: Text(
                      "${coinsProvider.symbol} ${coinsProvider.coins[index].currentprice}",
                    ),
                  );
                },
              ));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await coinsProvider.fetchCoins();
            },
            child: const Text("No Data Found"),
          );
        }
      }
    });
  }
}
