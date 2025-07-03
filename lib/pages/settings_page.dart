import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/currency/currency_provider.dart';
import 'package:shopping_app/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Consumer<ThemeProvider>(
                    builder:
                        (
                          BuildContext context,
                          ThemeProvider themeProvider,
                          Widget? child,
                        ) {
                          return Switch(
                            value: Provider.of<ThemeProvider>(
                              context,
                            ).isDarkMode,
                            onChanged: (bool value) {
                              themeProvider.toggleTheme();
                            },
                          );
                        },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Currency',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Consumer<CurrencyProvider>(
                    builder:
                        (
                          BuildContext context,
                          CurrencyProvider curr,
                          Widget? child,
                        ) {
                          return DropdownButton<String>(
                            value: curr.selectedCurrency,
                            underline: Container(),
                            items: curr.currencies.map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              if (newVal != null) {
                                curr.selectedCurrency = newVal;
                              }
                            },
                          );
                        },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
