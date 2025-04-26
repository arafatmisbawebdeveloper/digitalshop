import 'package:get/get.dart';

class CartController extends GetxController {
  // Cart items stored as a list of maps
  var cartItems = <Map<String, dynamic>>[].obs;

  // Total price
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item['price']);

  // Add item to cart
  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  // Remove item from cart
  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  // Clear all items in the cart
  void clearCart() {
    cartItems.clear();
  }
}
