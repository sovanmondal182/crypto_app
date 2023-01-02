import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final Cryptocurrency coin;
  DetailsPage({Key? key, required this.id, required this.coin})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget CoinPerformance(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(
      builder: (context, coinsProvider, child) {
        List<Cryptocurrency> favorites = coinsProvider.coins
            .where((element) => element.isfavorite == true)
            .toList();
        return Scaffold(
          appBar: AppBar(
            actionsIconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Details'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 0,
              ),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(widget.coin.image!),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ("${widget.coin.name!} (${widget.coin.symbol!.toUpperCase()})"),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        (widget.coin.isfavorite == true)
                            ? IconButton(
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () async {
                                  await coinsProvider
                                      .removefavorites(widget.coin);
                                },
                                icon: Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const Icon(
                                        size: 20,
                                        Icons.remove_red_eye_rounded,
                                        color: Colors.blue,
                                      ),
                                      Text('WatchList',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            : IconButton(
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  coinsProvider.addfavorites(widget.coin);
                                },
                                icon: Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size: 20,
                                        Icons.remove_red_eye_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                      Text(
                                        'WatchList',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${coinsProvider.symbol} ${widget.coin.currentprice!.toStringAsFixed(4)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          (widget.coin.pricechangepercentage_24h! > 0)
                              ? "▲ +${widget.coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (+${widget.coin.pricechange_24h!.toStringAsFixed(4)})"
                              : "▼ ${widget.coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (${widget.coin.pricechange_24h!.toStringAsFixed(4)})",
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.coin.pricechangepercentage_24h! > 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Coin Performance'),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        CoinPerformance('Market Cap',
                            "${coinsProvider.symbol} ${widget.coin.marketcap!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('Volume',
                            "${coinsProvider.symbol} ${widget.coin.totalvolume!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('Circulating Supply',
                            "${coinsProvider.symbol} ${widget.coin.circulatingsupply!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('24H High',
                            "${coinsProvider.symbol} ${widget.coin.high_24h!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('24H Low',
                            "${coinsProvider.symbol} ${widget.coin.low_24h!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('All Time High',
                            "${coinsProvider.symbol} ${widget.coin.ath!.toStringAsFixed(4)}"),
                        SizedBox(
                          height: 10,
                        ),
                        CoinPerformance('All Time Low',
                            "${coinsProvider.symbol} ${widget.coin.atl!.toStringAsFixed(4)}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
