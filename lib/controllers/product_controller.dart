import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;
  var categoryList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchAllProducts();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        categoryList.assignAll(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch categories');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        productList.assignAll(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
