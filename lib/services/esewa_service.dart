import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/pages/order_placed_page.dart';

class EsewaService {
  EsewaService._();

  static final EsewaService esewaInstance = EsewaService._();

  EsewaConfig esewaConfig = EsewaConfig(
    clientId: dotenv.env['CLIENT_ID_ESEWA']!,
    secretId: dotenv.env['SECRET_KEY_ESEWA']!,
    environment: Environment.test,
  );

  void makeEsewaPayment(
    BuildContext context,
    double price, {
    String callback = 'https://example.com/callback',
  }) {
    final CartModel cart = Provider.of<CartModel>(context, listen: false);

    print('---ESEWA---');
    EsewaFlutterSdk.initPayment(
      esewaConfig: esewaConfig,
      esewaPayment: EsewaPayment(
        productId: cart.getID(),
        productName: cart.getName(),
        productPrice: price.toString(),
        callbackUrl: callback,
      ),
      onPaymentSuccess: (EsewaPaymentSuccessResult data) {
        print(data);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const OrderPlacedPage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      onPaymentFailure: () {
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
              content: const Text('Please try again later!'),
              contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
      },
      onPaymentCancellation: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Paymemt Cancelled!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              content: const Text('You have Cancelled the Payment!'),
              contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
      },
    );
  }
}
