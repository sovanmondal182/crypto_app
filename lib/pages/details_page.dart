import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:crypto_app/widgets/coin_performance.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final Cryptocurrency coin;
  const DetailsPage({Key? key, required this.id, required this.coin})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeData =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Consumer<CoinsProvider>(
        builder: (context, coinsProvider, child) {
          Cryptocurrency coin = coinsProvider.fetchCoinsdByID(widget.id);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 0,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: NetworkImage(coin.image!),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              ("${coin.name!} (${coin.symbol!.toUpperCase()})"),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        LikeButton(
                          size: 25,
                          circleColor: const CircleColor(
                              start: Color(0xFFE26D13), end: Color(0xFFE09119)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0xFFE26D13),
                            dotSecondaryColor: Color(0xFFE09119),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: (coin.isfavorite == true)
                                  ? Colors.red
                                  : (themeData.themeMode == ThemeMode.dark)
                                      ? Colors.white
                                      : Colors.grey,
                              size: 25,
                            );
                          },
                          onTap: (isLiked) async {
                            if ((coin.isfavorite == false)) {
                              await coinsProvider.addfavorites(coin);
                              return isLiked = coin.isfavorite!;
                            } else {
                              await coinsProvider.removefavorites(coin);
                              return isLiked = coin.isfavorite!;
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "${coinsProvider.symbol} ${coin.currentprice!.toStringAsFixed(4)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (coin.pricechangepercentage_24h! > 0)
                              ? "▲ +${coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (+${coin.pricechange_24h!.toStringAsFixed(4)})"
                              : "▼ ${coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (${coin.pricechange_24h!.toStringAsFixed(4)})",
                          style: TextStyle(
                              fontSize: 15,
                              color: coin.pricechangepercentage_24h! > 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CoinPerformance(coin: coin),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
