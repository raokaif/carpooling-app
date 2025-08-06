import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  const MyRides({super.key});

  @override
  State<MyRides> createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  Future<void> deleteRide(String rideId) async {
    try {
      await FirebaseFirestore.instance.collection('rides').doc(rideId).delete();
    } catch (e) {
      print('Error deleting ride: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCurrentUserRides() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception("User not logged in");

      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('rides')
              .where('userId', isEqualTo: currentUser.uid)
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs
          .map((doc) => {...doc.data(), 'rideId': doc.id})
          .toList();
    } catch (e) {
      print("Error fetching user rides: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Rides',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCurrentUserRides(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading rides'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('No rides found'),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }

          final rides = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: rides.length + 1,
              itemBuilder: (context, index) {
                if (index < rides.length) {
                  final ride = rides[index];
                  return Dismissible(
                    key: Key(ride['rideId']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) async {
                      await deleteRide(ride['rideId']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ride deleted')),
                      );
                      setState(() {});
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${ride['date']}'),
                            Text('Time: ${ride['time']}'),
                            const SizedBox(height: 8),
                            Text('From: ${ride['source']}'),
                            Row(
                              children: [
                                Text('To: ${ride['destination']}'),
                                const Spacer(),
                                const Text(
                                  'Swipe <- to delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Price: Rs. ${ride['price']}'),
                            Text('Seats: ${ride['seats']}'),
                            Text('Car Model: ${ride['carModel'] ?? "N/A"}'),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text(
                        'Refresh',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
