import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'dart:convert';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:shopping_app/pages/order_placed_page.dart';

class KhaltiServiceCustom {
  KhaltiServiceCustom._();

  static final KhaltiServiceCustom khaltiInstance = KhaltiServiceCustom._();

  final String END_POINT = 'https://dev.khalti.com/api/v2/epayment/initiate/';

  Future<String> getPidX(
    BuildContext context,
    double amount, {
    String returnUrl = 'https://example.com/payment/',
    String websiteUrl = 'https://example.com/',
  }) async {
    final CartModel cart = Provider.of<CartModel>(context, listen: false);

    String pidX = '';

    Map<String, String> headers = {
      'Authorization': 'Key ${dotenv.env['SECRET_KEY_KHALTI']!}',
      'Content-Type': 'application/json',
    };

    final String payloadEncoded = jsonEncode(<String, dynamic>{
      'return_url': 'https://example.com/',
      'website_url': 'https://example.com/',
      'amount': convertRupeesToPaisa(amount),
      'purchase_order_id': cart.getID(),
      'purchase_order_name': cart.getName(),
    });

    http.Response response = await http.post(
      Uri.parse(END_POINT),
      headers: headers,
      body: payloadEncoded,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print('code 200');
      final Map<String, dynamic> data = jsonDecode(response.body);
      pidX = data['pidx'];
      print(pidX);
      return pidX;
    }
    return pidX;
  }

  int convertRupeesToPaisa(double rupees) {
    return (rupees * 100).toInt();
  }

  Future<void> khaltiPayment(BuildContext context, double amount) async {
    String pidx = await getPidX(context, amount);
    print('called khalti func');

    final KhaltiPayConfig payConfig = KhaltiPayConfig(
      publicKey:
          'live_public_key_979320ffda734d8e9f7758ac39ec775f', // This is a dummy public key for example purpose
      pidx: pidx,
      environment: Environment.test,
    );

    final Khalti? instance = await Khalti.init(
      payConfig: payConfig,
      onPaymentResult: (PaymentResult result, Khalti khalti) {
        print('PaymentResult payload: ${result.payload}');
        if (result.payload?.status!.toLowerCase() == 'completed') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const OrderPlacedPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Paymemt Failed!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                content: Text('Status: ${result.payload?.status ?? 'Unknown'}'),
                contentTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                contentPadding: const EdgeInsets.all(8),
              );
            },
          );
        }
        khalti.close(context);
      },
      onMessage:
          (
            Khalti khalti, {
            Object? description,
            int? statusCode,
            KhaltiEvent? event,
            bool? needsPaymentConfirmation,
          }) {
            print('Khalti Message: $description');
            // khalti.close(context);
          },
      onReturn: () async {
        print('Returned from Khalti');
      },
    );

    if (instance != null) {
      if (context.mounted) {
        instance.open(context);
      }
    } else {
      print('Failed to init Khalti');
    }
  }
}
