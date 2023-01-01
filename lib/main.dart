import 'package:crypto_app/constants/themes.dart';
import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencySelectProvider>(
            create: (context) => CurrencySelectProvider()),
        ChangeNotifierProvider<CoinsProvider>(
            create: (context) => CoinsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
