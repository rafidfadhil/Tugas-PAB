import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41), // Background color
      appBar: AppBar(
        backgroundColor: Color(0xFF222736), // AppBar color
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white), // Text color
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blueAccent), // Border color when focused
                  ),
                ),
                style: TextStyle(color: Colors.white), // Input text color
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your email' : null,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white), // Text color
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blueAccent), // Border color when focused
                  ),
                ),
                style: TextStyle(color: Colors.white), // Input text color
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
                child: Text('Login'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement login logic
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white, // Button text color
                ),
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
