import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthService.instance.login(emailController.text.trim(),
                    passwordController.text.trim());
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('No account? Register here.'),
            )
          ],
        ),
      ),
    );
  }
}
