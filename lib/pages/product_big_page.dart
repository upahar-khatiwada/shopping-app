import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/currency/currency_helper.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/models/products_class.dart';

import 'cart_page.dart';

class ProductBigPage extends StatelessWidget {
  final ProductsClass individualProduct;
  const ProductBigPage({super.key, required this.individualProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        actions: <Widget>[
          Consumer<CartModel>(
            builder: (BuildContext context, CartModel cart, Widget? child) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => const CartPage(),
                    ),
                  );
                },
                icon: Badge(
                  label: Text(cart.totalItemCount.toString()),
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5),
              Center(
                child: Text(
                  individualProduct.productName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Image.asset(
                individualProduct.imagePath,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Description',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                CurrencyHelper.formatPrice(context, individualProduct.price),
                style: const TextStyle(fontSize: 15, color: Colors.orange),
              ),
              const SizedBox(height: 6),
              Text(
                individualProduct.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Seller',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                individualProduct.sellerName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Warranty',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                individualProduct.warranty,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Delivery Time',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                individualProduct.deliveryTime,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<CartModel>(
                builder: (BuildContext context, CartModel cart, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              // cart.removeItem(individualProduct);
                              if (cart.getQuantity(individualProduct) == 1) {
                                cart.removeItem(individualProduct);
                              }
                              cart.decreaseItemQuantity(individualProduct);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                          Text(
                            '${cart.getQuantity(individualProduct)}',
                            // '${individualProduct.itemQuantity}',
                            // '${cart.items[cart.items.indexOf(individualProduct)].itemQuantity}',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cart.addItem(individualProduct);
                              cart.increaseItemQuantity(individualProduct);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // cart.addItemFromBigScreen(individualProduct);
                          cart.addItem(individualProduct);
                          Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const CartPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
