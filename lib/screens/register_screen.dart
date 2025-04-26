import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
                AuthService.instance.register(emailController.text.trim(),
                    passwordController.text.trim());
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
