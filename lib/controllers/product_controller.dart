import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  // Observable Lists
  var products = <Map<String, dynamic>>[].obs;
  var categories = <String>[].obs;
  var cart = <Map<String, dynamic>>[].obs;

  // Loading status
  var isLoadingCategories = true.obs;
  var isLoadingProducts = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  // Fetch all categories
  void fetchCategories() async {
    try {
      isLoadingCategories(true);
      var response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        categories.value = List<String>.from(json.decode(response.body));
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoadingCategories(false);
    }
  }

  // Fetch all products
  void fetchProducts() async {
    try {
      isLoadingProducts(true);
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        products.value =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoadingProducts(false);
    }
  }

  // Fetch products by category
  void getProductsByCategory(String category) async {
    try {
      isLoadingProducts(true);
      var response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/category/$category'));
      if (response.statusCode == 200) {
        products.value =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print('Error fetching products by category: $e');
    } finally {
      isLoadingProducts(false);
    }
  }

  // Add product to cart
  void addToCart(Map<String, dynamic> product) {
    if (!cart.contains(product)) {
      cart.add(product);
      Get.snackbar(
        'Cart',
        'Product added successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Cart',
        'Product already in cart!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Remove product from cart
  void removeFromCart(Map<String, dynamic> product) {
    cart.remove(product);
    Get.snackbar(
      'Cart',
      'Product removed!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Clear the entire cart
  void clearCart() {
    cart.clear();
    Get.snackbar(
      'Cart',
      'Cart cleared!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
