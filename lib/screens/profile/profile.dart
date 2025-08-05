import 'package:carpooling_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                height: 150,
              ),
              Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange,
                  backgroundImage: AssetImage('assets/images/person.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

          if (userProvider.isLoading)
            const CircularProgressIndicator()
          else if (userProvider.userName != null)
            Text(
              userProvider.userName!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else
            const Text("No name found"),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () {},
                  child: const Text('Contact us'),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () {},
                  child: const Text('Help & Support'),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
