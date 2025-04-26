import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class CartPage extends StatelessWidget {
  final ProductController productController = Get.find();
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.cart.isEmpty) {
          return const Center(child: Text('Cart is empty'));
        }
        return ListView.builder(
          itemCount: productController.cart.length,
          itemBuilder: (context, index) {
            final item = productController.cart[index];
            return ListTile(
              title: Text('Product ID: ${item['productId']}'),
              subtitle: Text('Quantity: ${item['quantity']}'),
            );
          },
        );
      }),
    );
  }
}
