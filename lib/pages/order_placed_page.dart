import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/receipt.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/pages/home_page.dart';
import '../database/firestore_config.dart';

class OrderPlacedPage extends StatefulWidget {
  const OrderPlacedPage({super.key});

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final CartModel cart = Provider.of<CartModel>(context, listen: false);

    FireStoreConfig().saveOrders(
      cart.items,
      cart.getDeliveryLocation,
      cart.totalPrice.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Order Placed',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Receipt(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Provider.of<CartModel>(
                        context,
                        listen: false,
                      ).clearCart();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    label: const Text(
                      'Continue Shopping!',
                      style: TextStyle(fontSize: 13),
                    ),
                    icon: const Icon(Icons.shopping_cart_outlined, size: 23),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    label: const Text('Exit!', style: TextStyle(fontSize: 13)),
                    icon: const Icon(Icons.exit_to_app_outlined, size: 23),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
