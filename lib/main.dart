import 'package:digitalshop/screens/product_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/product_controller.dart';
import 'screens/all_products_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(ProductController()); // Initialize ProductController
  Get.put(CartController()); // Initialize CartController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Shop',
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(name: '/notification', page: () => const NotificationScreen()),
        GetPage(name: '/allProducts', page: () => const AllProductsScreen()),
        GetPage(
            name: '/productDetail', page: () => const ProductDetailScreen()),
      ],
    );
  }
}
