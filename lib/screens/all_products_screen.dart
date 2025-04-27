import 'package:digitalshop/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class AllProductsPage extends StatelessWidget {
  final String category;

  const AllProductsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    // Fetch the products immediately when the page opens
    if (category == 'all') {
      productController.fetchProducts(); // For all products
    } else {
      productController
          .getProductsByCategory(category); // For products by category
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        // Check the loading state for products
        if (productController.isLoadingProducts.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.products.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        final products = productController.products;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // two products per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailPage(product: product));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            product['image'] ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product['title'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\$${product['price'].toString()}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
