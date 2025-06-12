import 'package:flutter/material.dart';
import 'package:shopping_app/models/products_class.dart';

class CartModel extends ChangeNotifier {
  final List<ProductsClass> _items = <ProductsClass>[];
  //getter for getting the list of items
  List<ProductsClass> get items => _items;

  // getter for getting the length of added items
  int get itemCount => _items.length;

  int get totalItemCount {
    int totalCountOfItems = 0;
    for (ProductsClass item in _items) {
      totalCountOfItems += item.itemQuantity;
    }
    return totalCountOfItems;
  }

  double get totalPrice {
    double totPrice = 0;
    for (int i = 0; i < itemCount; i++) {
      totPrice += items[i].itemQuantity * items[i].price;
    }
    return totPrice;
  }

  int getQuantity(ProductsClass product) {
    final int index = _items.indexOf(product);

    if (index == -1) return 0;
    return _items[index].itemQuantity;
  }

  void increaseItemQuantity(ProductsClass product) {
    final int index = _items.indexOf(product);
    if (index != -1) {
      _items[index].itemQuantity++;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(ProductsClass product) {
    final int index = _items.indexOf(product);
    if (index != -1 && _items[index].itemQuantity > 0) {
      _items[index].itemQuantity--;
      notifyListeners();
    }
  }

  void addItem(ProductsClass product) {
    if (!_items.contains(product)) {
      _items.add(product);
    }
    // product.itemQuantity++;
    notifyListeners();
  }

  void addItemFromBigScreen(ProductsClass product) {
    if (!_items.contains(product)) {
      _items.add(product);
    }
    notifyListeners();
  }

  void removeItem(ProductsClass product) {
    _items.remove(product);
    if (product.itemQuantity > 0) {
      product.itemQuantity--;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool get isCartClear => itemCount == 0;
}
