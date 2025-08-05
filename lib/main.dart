import 'package:carpooling_app/providers/user_provider.dart';
import 'package:carpooling_app/screens/auth/auth.dart';
import 'package:carpooling_app/screens/main/main_screen.dart';
import 'package:carpooling_app/screens/rides/my_rides.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carpooling App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(0, 0, 0, 255),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}
