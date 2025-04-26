import 'package:digitalshop/screens/all_products_screen.dart';
import 'package:digitalshop/screens/cart_screen.dart';
import 'package:digitalshop/screens/notification_screen.dart';
import 'package:digitalshop/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              onTap: () => Get.find<AuthService>().logout(),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: productController.categories.length,
          itemBuilder: (context, index) {
            final category = productController.categories[index];
            return ListTile(
              title: Text(category),
              onTap: () {
                productController.fetchProductsByCategory(category);
                Get.to(() => AllProductsPage(category: category));
              },
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const NotificationPage());
          } else if (index == 2) {
            productController.fetchCart();
            Get.to(() => CartPage());
          }
        },
      ),
    );
  }
}
