import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/currency/currency_helper.dart';
import 'package:shopping_app/currency/currency_provider.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/services/esewa_service.dart';
import 'package:shopping_app/services/khalti_service.dart';
import 'package:shopping_app/services/stripe_service.dart';

enum CardType { card, esewa, khalti }

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double tempAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Checkout',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Consumer<CartModel>(
                builder: (BuildContext context, CartModel cart, Widget? child) {
                  bool isUSD =
                      Provider.of<CurrencyProvider>(context, listen: false).selectedCurrency ==
                      'usd';
                  tempAmount = isUSD
                      ? cart.totalPrice + 9.99
                      : cart.totalPrice * 136.5 + 9.99 * 136.5;
                  return Visibility(
                    visible: cart.getDeliveryLocation.isNotEmpty,
                    child: Card(
                      elevation: 2.0,
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _buildPriceRow(
                              'Items Total',
                              CurrencyHelper.formatPrice(
                                context,
                                cart.totalPrice,
                              ),
                              // '\$${cart.totalPrice.toStringAsFixed(2)}',
                            ),
                            const SizedBox(height: 8),
                            _buildPriceRow(
                              'Delivery Charge',
                              CurrencyHelper.formatPrice(context, 9.99),
                            ),
                            Divider(
                              height: 24,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            _buildPriceRow(
                              'Subtotal',
                              CurrencyHelper.formatPrice(
                                context,
                                (cart.totalPrice + 9.99),
                              ),
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Select your payment method: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildCardButton(
                context: context,
                imagePath: 'assets/cards/master_card.jpg',
                label: 'Card',
                type: CardType.card,
                onTap: () async {
                  // print('test');
                  await StripeService.stripeInstance.makePayment(
                    context,
                    tempAmount,
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildCardButton(
                context: context,
                imagePath: 'assets/cards/esewa.png',
                label: 'Esewa',
                type: CardType.esewa,
                onTap: () {
                  EsewaService.esewaInstance.makeEsewaPayment(
                    context,
                    tempAmount,
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildCardButton(
                context: context,
                imagePath: 'assets/cards/khalti.png',
                label: 'Khalti',
                type: CardType.khalti,
                onTap: () {
                  KhaltiServiceCustom.khaltiInstance.khaltiPayment(
                    context,
                    tempAmount,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCardButton({
    required BuildContext context,
    required String imagePath,
    required String label,
    required CardType type,
    required void Function()? onTap,
  }) {
    return SizedBox(
      width: 150,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            elevation: 2,
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imagePath, width: 30, height: 30),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
