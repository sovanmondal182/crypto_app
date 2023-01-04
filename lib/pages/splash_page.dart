import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // late List<dynamic> marketChart;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Coin',
                      style: TextStyle(
                          fontSize: 50,
                          color: (themeProvider.themeMode == ThemeMode.dark)
                              ? Colors.white
                              : Colors.black)),
                  const Text('UP',
                      style: TextStyle(fontSize: 50, color: Color(0xff4D64CF))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
