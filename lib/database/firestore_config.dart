import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/models/products_class.dart';

class FireStoreConfig {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveOrders(
    List<ProductsClass> orderedProducts,
    String deliveryLocation,
    String totalPriceOfOrder,
  ) async {
    final List<Map<dynamic, dynamic>> productsData = orderedProducts.map((
      ProductsClass product,
    ) {
      return <dynamic, dynamic>{
        'name': product.productName,
        'price': '\$${product.price}',
        'quantity': product.itemQuantity,
        'total_price': '\$${(product.itemQuantity * product.price)}',
      };
    }).toList();

    final Map<String, dynamic> userOrder = <String, dynamic>{
      'order_date': DateTime.now(),
      'ordered_by': FirebaseAuth.instance.currentUser?.email,
      'orders': productsData,
      'total_price_for_order': '\$$totalPriceOfOrder',
      'shipping_charge': '\$9.99',
      'delivery_location': deliveryLocation,
    };

    await db.collection('orders').add(userOrder);
  }
}
