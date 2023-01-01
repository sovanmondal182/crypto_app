import 'package:crypto_app/constants/themes.dart';
import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrencySelectProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: HomePage(),
      ),
    );
  }
}
