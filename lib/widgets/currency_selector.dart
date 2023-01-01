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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Currency: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              showCurrencyPicker(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                onSelect: (Currency currency) {
                  Provider.of<CurrencySelectProvider>(context, listen: false)
                      .setCurrency(currency.code);
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
                    Container(
                      child: Text(
                        currency ?? 'INR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
