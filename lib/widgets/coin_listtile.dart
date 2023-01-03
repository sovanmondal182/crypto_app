import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/network/apis.dart';
import 'package:crypto_app/pages/details_page.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinListTile extends StatelessWidget {
  final Cryptocurrency coin;
  const CoinListTile({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context, listen: false);

    CoinsProvider coinsProvider =
        Provider.of<CoinsProvider>(context, listen: false);
    return ListTile(
      onTap: () async {
        List<dynamic> marketChart =
            await API.getMarketChart(coin.id, coinsProvider.currency);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailsPage(
            id: coin.id!,
            coin: coin,
            chartData: marketChart,
          );
        }));
      },
      contentPadding: const EdgeInsets.only(left: 3, right: 3),
      title: Row(
        children: [
          Flexible(
            child: Text(coin.name!, overflow: TextOverflow.ellipsis),
          ),
          // const SizedBox(
          //   width: 5,
          // ),
          // (coin.isfavorite == true)
          //     ? GestureDetector(
          //         onTap: () {
          //           coinsProvider.removefavorites(coin);
          //           print(coin.id);
          //         },
          //         child: const Icon(
          //           size: 20,
          //           Icons.star,
          //           color: Colors.yellow,
          //         ),
          //       )
          //     : GestureDetector(
          //         onTap: () {
          //           coinsProvider.addfavorites(coin);
          //         },
          //         child: const Icon(
          //           size: 20,
          //           Icons.star_border,
          //           color: Colors.yellow,
          //         ),
          //       ),
        ],
      ),
      leading: coin.image == null
          ? CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Text(
                coin.symbol!.toUpperCase(),
                style: TextStyle(
                    color: (theme.themeMode == ThemeMode.dark)
                        ? Colors.white
                        : Colors.black),
              ),
            )
          : CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(coin.image!),
            ),
      subtitle: Text(coin.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${coinsProvider.symbol} ${coin.currentprice!.toStringAsFixed(4)}",
            style: const TextStyle(fontSize: 15),
          ),
          Text(
            (coin.pricechangepercentage_24h! > 0)
                ? "+${coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (+${coin.pricechange_24h!.toStringAsFixed(4)})"
                : "${coin.pricechangepercentage_24h!.toStringAsFixed(2)}% (${coin.pricechange_24h!.toStringAsFixed(4)})",
            style: TextStyle(
                fontSize: 10,
                color: coin.pricechangepercentage_24h! > 0
                    ? Colors.green
                    : Colors.red),
          ),
        ],
      ),
    );
  }
}
