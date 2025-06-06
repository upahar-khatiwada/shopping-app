import 'package:flutter/material.dart';
import 'package:shopping_app/models/products.dart';

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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
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
                '\$ ${individualProduct.price}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const Text('1'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // add to cart logic
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
