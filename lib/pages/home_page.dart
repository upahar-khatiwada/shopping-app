import 'package:flutter/material.dart';
import 'package:shopping_app/components/bottom_app_bar.dart';
import 'package:shopping_app/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: const BottomAppBarComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // backgroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        child: IconButton(
          icon: const Icon(
            Icons.home,
            // color: Theme.of(context).colorScheme.inversePrimary,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // Search Bar
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             hintText: 'Search products...',
      //             prefixIcon: Icon(Icons.search),
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             filled: true,
      //             fillColor: Theme.of(context).colorScheme.surface,
      //           ),
      //         ),
      //       ),
      //
      //       // Categories Section
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //         child: Text(
      //           'Categories',
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Theme.of(context).colorScheme.inversePrimary,
      //           ),
      //         ),
      //       ),
      //
      //       SizedBox(
      //         height: 100,
      //         child: ListView(
      //           scrollDirection: Axis.horizontal,
      //           children: [
      //             _buildCategoryItem(
      //               context,
      //               Icons.phone_android,
      //               'Electronics',
      //             ),
      //             // _buildCategoryItem(context, Icons.local_dining, 'Food'),
      //             _buildCategoryItem(context, Icons.face, 'Beauty'),
      //             // _buildCategoryItem(context, Icons.home, 'Home'),
      //             _buildCategoryItem(context, Icons.sports_esports, 'Games'),
      //           ],
      //         ),
      //       ),
      //
      //       // Featured Products
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Text(
      //           'Featured Products',
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Theme.of(context).colorScheme.inversePrimary,
      //           ),
      //         ),
      //       ),
      //
      //       GridView.count(
      //         shrinkWrap: true,
      //         physics: NeverScrollableScrollPhysics(),
      //         crossAxisCount: 2,
      //         childAspectRatio: 0.8,
      //         padding: EdgeInsets.all(8),
      //         children: [
      //           _buildProductCard(
      //             context,
      //             'Smartphone',
      //             '\$599',
      //             'assets/phone.jpg',
      //           ),
      //           _buildProductCard(
      //             context,
      //             'Headphones',
      //             '\$199',
      //             'assets/headphones.jpg',
      //           ),
      //           _buildProductCard(
      //             context,
      //             'Smart Watch',
      //             '\$249',
      //             'assets/watch.jpg',
      //           ),
      //           _buildProductCard(
      //             context,
      //             'Laptop',
      //             '\$999',
      //             'assets/laptop.jpg',
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// Widget _buildCategoryItem(BuildContext context, IconData icon, String label) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: Theme.of(context).colorScheme.secondary,
//           child: Icon(
//             icon,
//             color: Theme.of(context).colorScheme.inversePrimary,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildProductCard(
//   BuildContext context,
//   String name,
//   String price,
//   String imagePath,
// ) {
//   return Card(
//     elevation: 2,
//     margin: EdgeInsets.all(8),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//             child: Container(
//               color: Colors.grey[200],
//               child: Center(
//                 child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey),
//               ),
//             ),
//             // In a real app, you would use Image.asset(imagePath) or Image.network()
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 4),
//               Text(
//                 price,
//                 style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   child: Text('Add to Cart'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
