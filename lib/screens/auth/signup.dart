import 'package:carpooling_app/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter a password';
    if (value.length < 8) return 'Password must be at least 8 characters';

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));

    if (!hasUppercase) return 'Include an uppercase letter';
    if (!hasLowercase) return 'Include a lowercase letter';
    if (!hasDigit) return 'Include a number';

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void signUp() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name.text,
        'email': email.text,
        'createdAt': Timestamp.now(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup successful!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup failed: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your Name',
                  prefixIcon: Icon(Icons.person),
                  border: border,
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.mail),
                  border: border,
                ),
                validator:
                    (value) =>
                        value == null || !value.contains('@')
                            ? 'Enter a valid email'
                            : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: password,
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
                validator: _validatePassword,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: confirmPassword,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your Password',
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
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                  ),
                  onPressed: signUp,
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
      ),
    );
  }
}
