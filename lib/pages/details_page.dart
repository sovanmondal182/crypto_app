import 'package:coinup/models/crypto_currency.dart';
import 'package:coinup/providers/coins_provider.dart';
import 'package:coinup/providers/theme_provider.dart';
import 'package:coinup/widgets/coin_performance.dart';
import 'package:coinup/widgets/market_chart.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final Cryptocurrency coin;
  final List<dynamic> chartData1;
  final List<dynamic> chartData7;
  final List<dynamic> chartData30;
  final List<dynamic> chartData365;
  final List<dynamic> chartDatamax;
  const DetailsPage(
      {Key? key,
      required this.id,
      required this.coin,
      required this.chartData1,
      required this.chartData7,
      required this.chartData30,
      required this.chartData365,
      required this.chartDatamax})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

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
                  SizedBox(
                    height: 250,
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: tabController,
                      children: [
                        MarketChart(
                          id: coin.id!,
                          chartData: widget.chartData1,
                          days: 1,
                        ),
                        MarketChart(
                          id: coin.id!,
                          chartData: widget.chartData7,
                          days: 7,
                        ),
                        MarketChart(
                          id: coin.id!,
                          chartData: widget.chartData30,
                          days: 30,
                        ),
                        MarketChart(
                          id: coin.id!,
                          chartData: widget.chartData365,
                          days: 365,
                        ),
                        MarketChart(
                          id: coin.id!,
                          chartData: widget.chartDatamax,
                          days: 1825,
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                      indicatorColor: const Color(0xff4D64CF),
                      controller: tabController,
                      labelColor: const Color(0xff4D64CF),
                      unselectedLabelColor:
                          (themeData.themeMode == ThemeMode.dark)
                              ? Colors.white
                              : Colors.black,
                      tabs: const [
                        Tab(
                          child: Text('1D'),
                        ),
                        Tab(
                          child: Text('1W'),
                        ),
                        Tab(
                          child: Text('1M'),
                        ),
                        Tab(
                          child: Text('1Y'),
                        ),
                        Tab(
                          child: Text('5Y'),
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  CoinPerformance(coin: coin),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
