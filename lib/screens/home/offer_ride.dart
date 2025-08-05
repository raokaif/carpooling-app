// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:carpooling_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void addRide({
  required BuildContext context,
  required String source,
  required String destination,
  required String date,
  required String time,
  required int seats,
  required String carModel,
  required String price,
}) async {
  final navigator = Navigator.of(context);
  final scaffold = ScaffoldMessenger.of(context);
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    await FirebaseFirestore.instance.collection('rides').add({
      'name': userProvider.userName ?? 'Unknown User',
      'source': source,
      'destination': destination,
      'date': date,
      'time': time,
      'seats': seats,
      'carModel': carModel,
      'price': price,
      'createdAt': Timestamp.now(),
    });

    navigator.pop();
    scaffold.showSnackBar(SnackBar(content: Text('Ride added successfully')));
  } catch (e) {
    scaffold.showSnackBar(SnackBar(content: Text('Error adding ride: $e')));
  }
}

void offerRideSheet(
  BuildContext context,
  String source,
  String destination,
  String date,
  String time,
) {
  int counter = 1;
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.my_location, color: Colors.blue),
                                Text(source),
                              ],
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_downward, color: Colors.grey),
                            SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.red),
                                Text(destination),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(date),
                            SizedBox(height: 10),
                            Text(time),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seats',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        Row(
                          children: [
                            Text('Available Seats'),
                            Spacer(),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey[100],
                              child: IconButton(
                                onPressed: () {
                                  if (counter > 1) {
                                    setModalState(() => counter--);
                                  }
                                },
                                icon: Icon(Icons.remove, size: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                counter.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey[100],
                              child: IconButton(
                                onPressed: () {
                                  setModalState(() => counter++);
                                },
                                icon: Icon(Icons.add, size: 15),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Car',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: carModelController,
                            cursorHeight: 20,

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Please Enter Car Model',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        Text(
                          'Price',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),

                        SizedBox(
                          height: 40,

                          child: TextField(
                            controller: priceController,
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Please Enter Price of a seat',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (carModelController.text.isEmpty ||
                            priceController.text.isEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all fields')),
                          );
                          return;
                        }

                        addRide(
                          context: context,
                          source: source,
                          destination: destination,
                          date: date,
                          time: time,
                          seats: counter,
                          carModel: carModelController.text,
                          price: priceController.text,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Offer Ride',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
