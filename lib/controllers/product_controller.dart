import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var isLoading = false.obs;
  var categories = [].obs;
  var products = [].obs;
  var cart = [].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    isLoading(true);
    var response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      categories.value = jsonDecode(response.body);
    }
    isLoading(false);
  }

  void fetchProductsByCategory(String category) async {
    isLoading(true);
    var response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
    if (response.statusCode == 200) {
      products.value = jsonDecode(response.body);
    }
    isLoading(false);
  }

  void fetchAllProducts() async {
    isLoading(true);
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      products.value = jsonDecode(response.body);
    }
    isLoading(false);
  }

  void fetchCart() async {
    isLoading(true);
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/carts/1'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      cart.value = data['products'];
    }
    isLoading(false);
  }
}
