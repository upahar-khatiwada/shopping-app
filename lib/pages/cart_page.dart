import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Function(BuildContext)? deleteFunction;

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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Are you sure you want to clear the cart?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,

                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              cart.clearCart();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
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
              ? Center(
                  child: Text(
                    'No items in cart!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      overflow: TextOverflow.visible,
                      fontSize: 20,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Consumer<CartModel>(
                    builder: (BuildContext context, CartModel cart, Widget? child) {
                      return ListView.builder(
                        itemCount: cart.itemCount,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: <Widget>[
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    cart.removeItem(cart.items[index]);
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ],
                            ),
                            child: Card(
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
                                                cart.items[index].productName,
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.inversePrimary,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\$ ${(cart.items[index].price * cart.items[index].itemQuantity)}',
                                                style: const TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Quantity: ${cart.items[index].itemQuantity}',
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.inversePrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: () {
                                                      cart.decreaseItemQuantity(
                                                        cart.items[index],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                                  ),
                                                  Text(
                                                    '1',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      cart.increaseItemQuantity(
                                                        cart.items[index],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        SizedBox(
                                          height: 100,
                                          width: 150,
                                          child: Image.asset(
                                            cart.items[index].imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
