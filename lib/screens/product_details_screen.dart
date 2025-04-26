import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product['image'], height: 150),
            const SizedBox(height: 20),
            Text(product['description']),
            const SizedBox(height: 20),
            Text('Price: \$${product['price']}',
                style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
