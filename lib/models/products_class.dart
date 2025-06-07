class ProductsClass {
  late final String productName;
  late final String description;
  late final String imagePath;
  late final double price;
  late final String category;
  late final String warranty;
  late final String deliveryTime;
  late final String sellerName;
  int itemQuantity;

  ProductsClass({
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.warranty,
    required this.deliveryTime,
    required this.sellerName,
    required this.itemQuantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsClass &&
          runtimeType == other.runtimeType &&
          productName == other.productName;

  @override
  int get hashCode => productName.hashCode;
}
