import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencySelectProvider>(context).currency;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Currency: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            showCurrencyPicker(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              context: context,
              showFlag: true,
              showCurrencyName: true,
              showCurrencyCode: true,
              onSelect: (Currency currency) async {
                Provider.of<CurrencySelectProvider>(context, listen: false)
                    .setCurrency(currency.code);
                Provider.of<CurrencySelectProvider>(context, listen: false)
                    .setCurrencySymbol(currency.symbol);
                await Provider.of<CoinsProvider>(context, listen: false)
                    .fetchCoins();
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    currency ?? 'INR',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.arrowtriangle_down_fill,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
