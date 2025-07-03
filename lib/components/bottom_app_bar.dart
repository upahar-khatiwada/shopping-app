// bottom app bar for cart page

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/currency/currency_helper.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/pages/location_page.dart';

class CartPageBottomAppBar extends StatelessWidget {
  const CartPageBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (BuildContext context, CartModel cart, Widget? child) {
        return BottomAppBar(
          elevation: 8,
          color: Theme.of(context).colorScheme.secondary,
          // height: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Total: ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: CurrencyHelper.formatPrice(
                            context,
                            cart.totalPrice,
                          ),
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Shipping Fee: ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: CurrencyHelper.formatPrice(context, 9.99),
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => const LocationPage(),
                    ),
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                ),
                child: Text(
                  'Check Out!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
