import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pengembangan_aplikasi/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Future<void> handleSignIn() async {
      if (_formKey.currentState!.validate()) {
        setState(() => isLoading = true);
        
        bool loggedIn = await authProvider.login(
          email: emailController.text,
          password: passwordController.text,
        );

        if (loggedIn) {
          Navigator.pushReplacementNamed(context, '/homepage');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to login, please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }

        setState(() => isLoading = false);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF222736), // AppBar color
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) => (value == null || value.isEmpty) ? 'Enter your email' : null,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) => (value == null || value.isEmpty) ? 'Enter your password' : null,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Button background color
                  onPrimary: Colors.white, // Button text color
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : const Text('Login'),
                onPressed: handleSignIn,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white, // Button text color
                ),
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}