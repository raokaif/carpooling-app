import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onLoginTap;

  const SignUpPage({super.key, required this.onLoginTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: const BorderSide(color: Color.fromRGBO(208, 206, 206, 1)),
  );
  bool _isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your Name',
                prefixIcon: Icon(Icons.person),
                border: border,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                prefixIcon: Icon(Icons.mail),
                border: border,
              ),
            ),
            SizedBox(height: 20),

            TextField(
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                border: border,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Enter your Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                border: border,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                ),
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: widget.onLoginTap,
              child: Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }
}
