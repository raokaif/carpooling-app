import 'package:carpooling_app/screens/login.dart';
import 'package:carpooling_app/screens/signup.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _currentIndex == 0;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          // Login / Signup switch with underline
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _animateToPage(0),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLogin ? Colors.blue : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 60,
                      color: isLogin ? Colors.blue : Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40),
              GestureDetector(
                onTap: () => _animateToPage(1),
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: !isLogin ? Colors.blue : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 60,
                      color: !isLogin ? Colors.blue : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 500,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: [
                LoginPage(onSignUpTap: () => _animateToPage(1)),
                SignUpPage(onLoginTap: () => _animateToPage(0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
