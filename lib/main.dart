import 'package:digitalshop/screens/home_screen.dart';
import 'package:digitalshop/screens/login_screen.dart';
import 'package:digitalshop/screens/register_screen.dart';
import 'package:digitalshop/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Don't forget
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
      ],
    );
  }
}
