import 'package:digitalshop/screens/all_products_screen.dart';
import 'package:digitalshop/screens/cart_screen.dart';
import 'package:digitalshop/screens/home_screen.dart';
import 'package:digitalshop/screens/login_screen.dart';
import 'package:digitalshop/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/product_controller.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB0VsdJWZjMBv6_kqzaOrgqoOg4RjD8MVw", // <-- YOURS
      authDomain: "digitalshop-485ad.firebaseapp.com",
      projectId: "digitalshop-485ad",
      storageBucket: "digitalshop-485ad.firebasestorage.app",
      messagingSenderId: "468275975090",
      appId: "1:468275975090:web:8d9280f2f0d9d60da14aab",
    ),
  );
  Get.put(AuthService());
  Get.put(ProductController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Shop',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(
            name: '/all-products', page: () => AllProductsPage(category: '')),
        GetPage(name: '/cart', page: () => CartPage()),
      ],
    );
  }
}
