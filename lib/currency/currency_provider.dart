import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class CurrencyProvider extends ChangeNotifier {
  final Box<dynamic> currencyBox = Hive.box('currency_box');

  String _selectedCurrency = 'npr';
  final List<String> _currencies = <String>['usd', 'npr'];

  CurrencyProvider() {
    final String _currCurrency = currencyBox.get(
      'currency',
      defaultValue: 'npr',
    );
    _selectedCurrency = _currCurrency;
    logger.i('Loaded currency from Hive: $_selectedCurrency');
  }

  String get selectedCurrency => _selectedCurrency;

  set selectedCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
    currencyBox.put('currency', newCurrency);
    logger.i('Saved currency to Hive: $newCurrency');
    notifyListeners();
  }

  List<String> get currencies => _currencies;
}
