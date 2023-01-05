import 'package:coinup/constants/app_themes.dart';
import 'package:coinup/pages/splash_page.dart';
import 'package:coinup/providers/coins_provider.dart';
import 'package:coinup/providers/currency_select_provider.dart';
import 'package:coinup/providers/theme_provider.dart';
import 'package:coinup/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? 'light';
  runApp(MyApp(
    currentTheme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String currentTheme;
  const MyApp({super.key, required this.currentTheme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencySelectProvider>(
            create: (context) => CurrencySelectProvider()),
        ChangeNotifierProvider<CoinsProvider>(
            create: (context) => CoinsProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(currentTheme)),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashPage(),
        );
      }),
    );
  }
}
