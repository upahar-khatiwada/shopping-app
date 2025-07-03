import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_provider.dart';

class CurrencyHelper {
  static String formatPrice(BuildContext context, double price) {
    final CurrencyProvider currencyProvider = Provider.of<CurrencyProvider>(context);

    if (currencyProvider.selectedCurrency == 'usd') {
      return '\$${price.toStringAsFixed(2)}';
    } else if (currencyProvider.selectedCurrency == 'npr') {
      final double converted = price * 136.5;
      return 'Rs. ${converted.toStringAsFixed(2)}';
    }

    return price.toString();
  }
}
