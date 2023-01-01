import 'package:crypto_app/pages/coins.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:crypto_app/widgets/currency_selector.dart';
import 'package:crypto_app/widgets/greeting_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrencySelectProvider>(
        builder: (context, currencySelectProvider, child) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GreetingText(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CurrencySelector(),
                  TabBar(controller: tabController, tabs: const [
                    Tab(
                      child: Text(
                        'Coins',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Favorites',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: tabController,
                      children: [
                        const Coins(),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Favorites'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
