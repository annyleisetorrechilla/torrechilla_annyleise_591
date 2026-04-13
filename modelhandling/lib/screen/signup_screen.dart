import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = AuthController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isLoading = false;

  void register() async {
    // all form is empty return null value
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmController.text.isEmpty) {
      showMessage('Please fill all fields');
      return;
    }

    // check password confirmation
    if (passwordController.text.trim() != confirmController.text.trim()) {
      showMessage('Password do not match');
      return;
    }

    // check password length
    if (passwordController.text.length < 4) {
      showMessage('Password must be at least 4 characters');
    }

    setState(() {
      isLoading = true;
    });
    final result = await controller.register(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });
    showMessage('User registered');
    if (result['success']) {
      Navigator.pop(context);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_add, size: 80, color: Colors.indigo),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Register to get started',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // Username
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password
                  TextField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}