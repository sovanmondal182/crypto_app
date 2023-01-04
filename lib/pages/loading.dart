import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/pages/details_page.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  final Cryptocurrency coin;
  const LoadingPage({Key? key, required this.coin}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // late List<dynamic> marketChart;

  Future<void> getData() async {
    CoinsProvider coinsProvider =
        Provider.of<CoinsProvider>(context, listen: false);
    List<dynamic> marketChart =
        await coinsProvider.fetchChartData(widget.coin.id!);
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DetailsPage(
          id: widget.coin.id!,
          coin: widget.coin,
          chartData1: marketChart[0],
          chartData7: marketChart[1],
          chartData30: marketChart[2],
          chartData365: marketChart[3],
          chartDatamax: marketChart[4],
        );
      }));
    } else {
      return;
    }
  }

  void navigationPage() async {
    await getData();
  }

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
