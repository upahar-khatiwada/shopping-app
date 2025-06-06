import 'package:shopping_app/models/products.dart';

class ProductsList {
  final List<ProductsClass> _products = <ProductsClass>[
    ProductsClass(
      productName: 'Smart Phone',
      description:
          'Experience cutting-edge performance with our latest smartphone, featuring a vibrant display, powerful processor, and long-lasting battery life.',
      imagePath: 'assets/shopping/smartphone.jpg',
      price: 499,
      category: 'Electronics',
      warranty: '1 year Available',
      deliveryTime: '1-2 Days',
      sellerName: 'Samsung Nepal',
    ),
    ProductsClass(
      productName: 'Face Wash',
      description:
          'Revitalize your skin with our dermatologist-approved face wash, designed to gently cleanse, reduce acne, and promote a radiant complexion.',
      imagePath: 'assets/shopping/facewash.jpg',
      price: 39,
      category: 'Beauty',
      warranty: 'No Warranty',
      deliveryTime: '1-2 Days',
      sellerName: 'Lavana',
    ),
    ProductsClass(
      productName: 'GTA V',
      description:
          'Step into the thrilling world of Grand Theft Auto V, an action-packed open-world game full of missions, chaos, and unforgettable characters.',
      imagePath: 'assets/shopping/gtav.jpeg',
      price: 100,
      category: 'Games',
      warranty: 'No Warranty',
      deliveryTime: '5-7 Days',
      sellerName: 'Kunyo',
    ),
    ProductsClass(
      productName: 'Keyboard',
      description:
          'Upgrade your typing experience with this hot-swappable mechanical keyboard, featuring tactile switches and customizable RGB lighting.',
      imagePath: 'assets/shopping/keyboard.jpg',
      price: 80,
      category: 'Electronics',
      warranty: '1 Year Warranty',
      deliveryTime: '3-5 Days',
      sellerName: 'Backseat Gaming',
    ),
  ];

  List<ProductsClass> get products => _products;
}
