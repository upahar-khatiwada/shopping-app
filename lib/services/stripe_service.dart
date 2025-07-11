import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/order_placed_page.dart';
import 'package:shopping_app/themes/theme_provider.dart';
import 'package:shopping_app/currency/currency_provider.dart';

class StripeService {
  StripeService._();

  static final StripeService stripeInstance = StripeService._();

  Future<void> makePayment(BuildContext context, double amount) async {
    String tempCurr = Provider.of<CurrencyProvider>(
      context,
      listen: false,
    ).selectedCurrency;
    try {
      String? clientSecret = await createPaymentIntent(
        context,
        amount,
        tempCurr,
      );

      if (clientSecret != null && context.mounted) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'haha ',
            style: Provider.of<ThemeProvider>(context, listen: false).themeMode,
          ),
        );
        await Stripe.instance.presentPaymentSheet();
        if (context.mounted) {
          // Provider.of<CartModel>(context, listen: false).clearCart();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<Widget>(
          //     builder: (BuildContext context) => const OrderPlacedPage(),
          //   ),
          // );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const OrderPlacedPage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error Occurred!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              content: Text(e.toString()),
              contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
      }
    }
  }

  Future<String?> createPaymentIntent(
    BuildContext context,
    double amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> payload = <String, dynamic>{
        'amount': calculateAmount(amount).toString(),
        'currency': currency,
      };

      final http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: payload,
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['client_secret'];
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error Occurred!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              content: Text(e.toString()),
              contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
      }
    }
    return null;
  }

  int calculateAmount(double amount) {
    return (amount * 100).round();
  }
}
