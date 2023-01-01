import 'package:crypto_app/network/apis.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String greeting = now.hour < 12
        ? 'Good Morning'
        : now.hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hi,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
                onTap: () {
                  final currency = Provider.of<CurrencySelectProvider>(context,
                          listen: false)
                      .currency;
                  API.getCoins(currency);
                },
                child: const Icon(CupertinoIcons.sun_max_fill, size: 30))
          ],
        ),
        const SizedBox(height: 10),
        Text(
          greeting,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
