import 'package:carpooling_app/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSignUpTap;

  const LoginPage({super.key, required this.onSignUpTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  bool isInitialized = false;

  //initialize the Google sign in
  Future<void> initSignIn() async {
    if (!isInitialized) {
      await googleSignIn.initialize(
        serverClientId:
            "216810061782-r0t4426t867565fcfp9t65ljge3e05f5.apps.googleusercontent.com",
      );
      isInitialized = true;
    }
  }

  //sign in with google method
  Future<UserCredential> signInWithGoogle() async {
    await initSignIn();
    final GoogleSignInAccount? account = await googleSignIn.authenticate();
    if (account == null) {
      throw FirebaseAuthException(
        code: "sign in aborted by user",
        message: "Sign in incompleted because user exists",
      );
    }
    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;
    GoogleSignInClientAuthorization? auth = await authClient
        .authorizationForScopes(['email', 'profile']);
    final accessToken = auth?.accessToken;
    if (accessToken == null) {
      final auth2 = await authClient.authorizationForScopes([
        'email',
        'profile',
      ]);
      if (auth2 == null) {
        throw FirebaseAuthException(
          code: 'No access Token',
          message: 'Failed to retrive google access token',
        );
      }
      auth = auth2;
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //sign out from both google and firebase
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainScreen();
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email or Password is incorrect')));
    }
  }

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
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                prefixIcon: Icon(Icons.mail),
                border: border,
              ),
            ),
            SizedBox(height: 20),
            TextField(
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
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                ),
                onPressed: signIn,
                child: Text(
                  'Login ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: widget.onSignUpTap,
              child: Text("Don't have an account? Sign up"),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 100, height: 2, color: Colors.grey[300]),
                Text(
                  '  or Log in with  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                ),
                Container(width: 100, height: 2, color: Colors.grey[300]),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  signInWithGoogle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScreen();
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 23,
                      child: Image.asset('assets/images/google.png'),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
