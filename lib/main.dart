import 'package:crypto_app/constants/app_themes.dart';
import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
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
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomePage(),
        );
      }),
    );
  }
}
