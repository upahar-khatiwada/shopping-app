import 'package:flutter/material.dart';
import 'package:shopping_app/components/bottom_app_bar_items.dart';

class BottomAppBarComponent extends StatelessWidget {
  const BottomAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 1,
      height: 60,
      color: Theme.of(context).colorScheme.secondary,
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomAppBarItems(onPressed: () {}, icon: Icons.grid_view_rounded),
          BottomAppBarItems(onPressed: () {}, icon: Icons.favorite),
          const SizedBox(width: 50),
          BottomAppBarItems(onPressed: () {}, icon: Icons.shopping_cart),
          BottomAppBarItems(onPressed: () {}, icon: Icons.person),
        ],
      ),
    );
  }
}
