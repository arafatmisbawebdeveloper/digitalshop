import 'package:digitalshop/screens/all_products_screen.dart';
import 'package:digitalshop/screens/cart_screen.dart';
import 'package:digitalshop/screens/login_screen.dart';
import 'package:digitalshop/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  HomePage({Key? key}) : super(key: key);
  void logout() async {
    // Example: If you are using SharedPreferences to store user data
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear(); // Clear user data (or any other method)

    // Navigate to the login screen and clear the navigation stack
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                  child: Text('Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24))),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Get.to(() => CartPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Digital Shop'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartPage());
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          productController.fetchCategories();
          productController.fetchProducts();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AllProductsPage(category: 'all'));
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Obx(() {
                  if (productController.isLoadingCategories.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.categories.length,
                    itemBuilder: (context, index) {
                      final category = productController.categories[index];
                      return GestureDetector(
                        onTap: () {
                          // Fetch products for the selected category
                          productController.getProductsByCategory(category);
                          Get.to(() => AllProductsPage(category: category));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade100,
                          ),
                          child: Center(
                            child: Text(
                              category.toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Recommended for You',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (productController.isLoadingProducts.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productController.products.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailPage(product: product));
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.network(
                                  product['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$${product['price']}",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:digitalshop/screens/all_products_screen.dart';
// import 'package:digitalshop/screens/cart_screen.dart';
// import 'package:digitalshop/screens/login_screen.dart';
// import 'package:digitalshop/screens/product_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/product_controller.dart';

// class HomePage extends StatelessWidget {
//   final ProductController productController = Get.find<ProductController>();

//   HomePage({Key? key}) : super(key: key);

//   // Function to log out user
//   void logout() async {
//     // Example: If you are using SharedPreferences to store user data
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.clear(); // Clear user data (or any other method)

//     // Navigate to the login screen and clear the navigation stack
//     Get.offAll(() => LoginPage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Center(
//                   child: Text('Menu',
//                       style: TextStyle(color: Colors.white, fontSize: 24))),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: const Text('Cart'),
//               onTap: () {
//                 Get.to(() => CartPage());
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: logout, // Call logout function when tapped
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text('Digital Shop'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               Get.to(() => CartPage());
//             },
//           )
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           productController.fetchCategories();
//           productController.fetchProducts();
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Categories',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => AllProductsPage(category: 'all'));
//                       },
//                       child: const Text('See All'),
//                     ),
//                   ],
//                 ),
//               ),
//               // Categories widget
//               SizedBox(
//                 height: 100,
//                 child: Obx(() {
//                   if (productController.isLoadingCategories.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: productController.categories.length,
//                     itemBuilder: (context, index) {
//                       final category = productController.categories[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Get.to(() => AllProductsPage(category: category));
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 10),
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.blue.shade100,
//                           ),
//                           child: Center(
//                             child: Text(
//                               category.toUpperCase(),
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: const Text(
//                   'Recommended for You',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Obx(() {
//                 if (productController.isLoadingProducts.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: productController.products.length,
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemBuilder: (context, index) {
//                     final product = productController.products[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(() => ProductDetailPage(product: product));
//                       },
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(20)),
//                                 child: Image.network(
//                                   product['image'],
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 product['title'],
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text(
//                                 "\$${product['price']}",
//                                 style: const TextStyle(color: Colors.green),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
