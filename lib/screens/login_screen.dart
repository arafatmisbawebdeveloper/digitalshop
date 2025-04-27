import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart'; // Your AuthService file

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  // Function to handle login logic
  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show error if email or password is empty
      Get.snackbar('Error', 'Please enter both email and password',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Call your authentication service (e.g., Firebase or custom backend)
    AuthService.instance.login(email, password); // Login user

    // After login, navigation will be handled by `AuthService`
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Email TextField
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),

            // Password TextField
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: loginUser, // Call loginUser function when pressed
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),

            // Navigate to Register Page if no account
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('No account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
