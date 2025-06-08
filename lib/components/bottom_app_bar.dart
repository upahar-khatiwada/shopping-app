import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart_model.dart';

class CartPageBottomAppBar extends StatelessWidget {
  const CartPageBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (BuildContext context, CartModel cart, Widget? child) {
        double totalPrice = 0;
        for (int i = 0; i < cart.itemCount; i++) {
          totalPrice += cart.items[i].itemQuantity * cart.items[i].price;
          print(totalPrice);
        }

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
                          text: '\$ $totalPrice',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   'Total: \$ $totalPrice',
                  //   style: TextStyle(
                  //     color: Theme.of(context).colorScheme.inversePrimary,
                  //   ),
                  // ),
                  const SizedBox(height: 2.0),
                  // Text(
                  //   'Shipping Fee: \$ 9.99',
                  //   style: TextStyle(
                  //     color: Theme.of(context).colorScheme.inversePrimary,
                  //   ),
                  // ),
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
                        const TextSpan(
                          text: '\$ 9.99',
                          style: TextStyle(
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
                onPressed: () {},
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
