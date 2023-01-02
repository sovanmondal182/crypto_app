import 'package:crypto_app/providers/currency_select_provider.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencySelectProvider>(
      builder: (context, currencySelectProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Currency: ',
              style: TextStyle(
                fontSize: 18,
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
                  onSelect: (Currency currency) {
                    currencySelectProvider.setCurrency(currency.code);
                    currencySelectProvider.setCurrencySymbol(currency.symbol);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Text(
                      currencySelectProvider.currency ?? 'INR',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      size: 9,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
