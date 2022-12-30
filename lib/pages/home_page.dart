import 'package:crypto_app/constants/greeting_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingText(),
              TabBar(controller: tabController, tabs: [
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
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Center(
                        child: Text('Coins'),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Favorites'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
