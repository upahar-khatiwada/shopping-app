import 'package:flutter/material.dart';
import 'package:shopping_app/models/products.dart';

class CartModel extends ChangeNotifier {
  final List<ProductsClass> _items = <ProductsClass>[];

  List<ProductsClass> get items => _items;

  int get itemCount => _items.length;

  void addItem(ProductsClass product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(ProductsClass product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool get isCartClear => itemCount == 0;
}
