import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/receipt.dart';
import 'package:shopping_app/models/cart_model.dart';
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
      body: const Receipt(),
    );
  }
}
