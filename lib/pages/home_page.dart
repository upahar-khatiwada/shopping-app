import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/categories_builder.dart';
import 'package:shopping_app/components/drawer.dart';
import 'package:shopping_app/components/products_card.dart';
import 'package:shopping_app/components/unFocusOnTap.dart';
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
  String categoryName = '';

  final List<String> productNames = ProductsList().products.map((
    ProductsClass product,
  ) {
    return product.productName.toLowerCase();
  }).toList();

  @override
  Widget build(BuildContext context) {
    return UnFocusOnTap(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return productNames.where((String productName) {
                      return productName.contains(
                        textEditingValue.text.toLowerCase(),
                      );
                    });
                  },
                  onSelected: (String selectedProduct) {
                    final ProductsClass product = ProductsList().products
                        .firstWhere(
                          (ProductsClass prod) =>
                              prod.productName.toLowerCase() ==
                              selectedProduct.toLowerCase(),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            ProductBigPage(individualProduct: product),
                      ),
                    );
                  },
                  fieldViewBuilder:
                      (
                        BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return StatefulBuilder(
                          builder:
                              (
                                BuildContext context,
                                StateSetter setInnerState,
                              ) {
                                textEditingController.addListener(() {
                                  setInnerState(() {});
                                });
                                return TextField(
                                  cursorColor: Theme.of(
                                    context,
                                  ).colorScheme.inversePrimary,
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Search products...',
                                    hintStyle: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                    ),
                                    suffixIcon: Visibility(
                                      visible:
                                          textEditingController.text.isNotEmpty,
                                      child: IconButton(
                                        onPressed: () {
                                          textEditingController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.tertiary,
                                      ),
                                    ),
                                  ),
                                );
                              },
                        );
                      },
                  optionsViewBuilder:
                      (
                        BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options,
                      ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height:
                                  // list tile's height is 50 pixels
                                  // displays scrollable suggestions if there are over 4 suggestions
                                  (options.length < 4 ? options.length : 4) *
                                  50,
                              child: ListView.builder(
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // final String option = options.elementAt(index);
                                  return ListTile(
                                    tileColor: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                    title: Text(options.elementAt(index)),
                                    onTap: () {
                                      onSelected(options.elementAt(index));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
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
                  child: Consumer<CartModel>(
                    builder:
                        (BuildContext context, CartModel cart, Widget? child) {
                          return Row(
                            children: <Widget>[
                              CategoriesBuilder(
                                icon: Icons.all_inclusive,
                                text: 'All',
                                onTap: () {
                                  setState(() {
                                    categoryName = '/all';
                                  });
                                },
                              ),
                              CategoriesBuilder(
                                icon: Icons.phone_android,
                                text: 'Electronics',
                                onTap: () {
                                  setState(() {
                                    categoryName = 'Electronics';
                                  });
                                },
                              ),
                              CategoriesBuilder(
                                icon: Icons.face,
                                text: 'Beauty',
                                onTap: () {
                                  setState(() {
                                    categoryName = 'Beauty';
                                  });
                                },
                              ),
                              CategoriesBuilder(
                                icon: Icons.sports_esports,
                                text: 'Games',
                                onTap: () {
                                  setState(() {
                                    categoryName = 'Games';
                                  });
                                },
                              ),
                              CategoriesBuilder(
                                icon: Icons.kitchen,
                                text: 'Kitchen',
                                onTap: () {
                                  setState(() {
                                    categoryName = 'Kitchen';
                                  });
                                },
                              ),
                              CategoriesBuilder(
                                icon: Icons.checkroom,
                                text: 'Clothing',
                                onTap: () {
                                  setState(() {
                                    categoryName = 'Clothing';
                                  });
                                },
                              ),
                            ],
                          );
                        },
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
                    children: ProductsList().products
                        .where(
                          (ProductsClass product) =>
                              product.category.contains(categoryName),
                        )
                        .map((ProductsClass product) {
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
                                      ProductBigPage(
                                        individualProduct: product,
                                      ),
                                ),
                              );
                            },
                          );
                        })
                        .toList(),
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
