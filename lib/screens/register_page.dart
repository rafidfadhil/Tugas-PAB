import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pengembangan_aplikasi/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleSignUp() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Berhasil Register',
              textAlign: TextAlign.center,
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Register',
              textAlign: TextAlign.center,
            )));
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41), // Background color
      appBar: AppBar(
        backgroundColor: Color(0xFF222736), // AppBar color
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 8.0),
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
                style: TextStyle(color: Colors.white),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your email' : null,
              ),
              SizedBox(height: 8.0),
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
                style: TextStyle(color: Colors.white),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your password'
                    : null,
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Button background color
                  onPrimary: Colors.white, // Button text color
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text('Register'),
                onPressed: handleSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
