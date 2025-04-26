import 'package:digitalshop/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class AllProductsPage extends StatelessWidget {
  final String category;
  final ProductController productController = Get.find();
  AllProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products - $category')),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              title: Text(product['title']),
              onTap: () {
                Get.to(() => ProductDetailPage(product: product));
              },
            );
          },
        );
      }),
    );
  }
}
