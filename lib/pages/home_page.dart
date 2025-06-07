import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/categories_builder.dart';
import 'package:shopping_app/components/drawer.dart';
import 'package:shopping_app/components/products_card.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/models/product_list.dart';
import 'package:shopping_app/models/products_class.dart';
import 'package:shopping_app/pages/product_big_page.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
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
      drawer: const MyDrawer(),
      // bottomNavigationBar: const BottomAppBarComponent(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   // backgroundColor: Theme.of(context).colorScheme.tertiary,
      //   backgroundColor: Colors.orange,
      //   shape: const CircleBorder(),
      //   child: IconButton(
      //     icon: const Icon(
      //       Icons.home,
      //       // color: Theme.of(context).colorScheme.inversePrimary,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {},
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search products..',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.surface,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    CategoriesBuilder(
                      icon: Icons.phone_android,
                      text: 'Electronics',
                      onTap: () {},
                    ),
                    CategoriesBuilder(
                      icon: Icons.face,
                      text: 'Beauty',
                      onTap: () {},
                    ),
                    CategoriesBuilder(
                      icon: Icons.sports_esports,
                      text: 'Games',
                      onTap: () {},
                    ),
                    CategoriesBuilder(
                      icon: Icons.kitchen,
                      text: 'Kitchen',
                      onTap: () {},
                    ),
                    CategoriesBuilder(
                      icon: Icons.checkroom,
                      text: 'Clothing',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Consumer<CartModel>(
              builder: (BuildContext context, CartModel cart, Widget? child) {
                return GridView.count(
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ProductsList().products.map((
                    ProductsClass product,
                  ) {
                    return ProductsCard(
                      productsClass: product,
                      onPressedAddToCartButton: () {
                        cart.addItem(product);
                        cart.increaseItemQuantity(product);
                      },
                      onPressedCard: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                ProductBigPage(individualProduct: product),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
