import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/models/product_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'Cart',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<CartModel>(
            builder: (BuildContext context, CartModel cart, Widget? child) {
              return IconButton(
                onPressed: () {
                  cart.clearCart();
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<CartModel>(
        builder: (BuildContext context, CartModel cart, Widget? child) {
          return cart.isCartClear
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: ListView.builder(
                    itemCount: ProductsList().products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Theme.of(context).colorScheme.secondary,
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          ProductsList()
                                              .products[index]
                                              .productName,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.inversePrimary,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$ ${ProductsList().products[index].price}',
                                          style: const TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.remove,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.add,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Text(
                                        //   'Quantity: 1',
                                        //   style: TextStyle(
                                        //     color: Theme.of(
                                        //       context,
                                        //     ).colorScheme.inversePrimary,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.asset(
                                      ProductsList().products[index].imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
