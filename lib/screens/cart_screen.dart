import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Obx(() {
        if (productController.cart.isEmpty) {
          return const Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        return ListView.builder(
          itemCount: productController.cart.length,
          itemBuilder: (context, index) {
            final product = productController.cart[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.network(
                  product['image'],
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  product['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("\$${product['price']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    productController.removeFromCart(product);
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (productController.cart.isEmpty) {
          return const SizedBox.shrink();
        }

        double totalPrice = productController.cart
            .fold(0.0, (sum, item) => sum + (item['price'] as double));

        return Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, -3),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Order Placed",
                    "Thank you for shopping!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    colorText: Colors.white,
                  );
                  productController.clearCart();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
