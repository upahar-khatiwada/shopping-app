import 'package:flutter/material.dart';
import 'package:shopping_app/models/products_class.dart';

// class ProductsCard extends StatelessWidget {
//   final ProductsClass productsClass;
//   final void Function() onPressedAddToCartButton;
//   final VoidCallback onPressedCard;
//   const ProductsCard({
//     super.key,
//     required this.productsClass,
//     required this.onPressedAddToCartButton,
//     required this.onPressedCard,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressedCard,
//       child: Padding(
//         padding: const EdgeInsets.all(4),
//         child: Card(
//           elevation: 2,
//           margin: const EdgeInsets.all(8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   productsClass.imagePath,
//                   // fit: BoxFit.cover,
//                   width: double.maxFinite,
//                   height: 150,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       productsClass.productName,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '\$ ${productsClass.price}',
//                       style: const TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: onPressedAddToCartButton,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           backgroundColor: Theme.of(
//                             context,
//                           ).colorScheme.secondary,
//                         ),
//                         child: Text(
//                           'Add to Cart',
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.inversePrimary,
//                             overflow: TextOverflow.visible,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProductsCard extends StatelessWidget {
  final ProductsClass productsClass;
  final VoidCallback onPressedAddToCartButton;
  final VoidCallback onPressedCard;

  const ProductsCard({
    super.key,
    required this.productsClass,
    required this.onPressedAddToCartButton,
    required this.onPressedCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCard,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.asset(
                  productsClass.imagePath,
                  width: double.infinity,
                  height: 148,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productsClass.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$ ${productsClass.price}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onPressedAddToCartButton,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
