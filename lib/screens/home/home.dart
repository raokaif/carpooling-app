import 'package:carpooling_app/constants/constants.dart';
import 'package:carpooling_app/screens/home/offer_ride.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final int _selectedIndex = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  bool showRide = false;

  String? source;
  String? destination;

  @override
  Widget build(BuildContext context) {
    String selectedDateString =
        "${_selectedDate.month.toString().padLeft(2, '0')}/"
        "${_selectedDate.day.toString().padLeft(2, '0')}/"
        "${_selectedDate.year}";

    String selectedTimeString = _selectedTime.format(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              DropdownSearch<String>(
                items: (f, c) => Constants.pakistanCities,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),

                  menuProps: MenuProps(
                    backgroundColor: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],

                    hintText: 'From',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                onChanged: (value) {
                  source = value;
                },
              ),

              SizedBox(height: 10),
              DropdownSearch<String>(
                items: (f, c) => Constants.pakistanCities,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),

                  menuProps: MenuProps(
                    backgroundColor: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'To',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                onChanged: (value) {
                  destination = value;
                },
              ),

              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${_selectedDate.month.toString().padLeft(2, '0')}/"
                            "${_selectedDate.day.toString().padLeft(2, '0')}/"
                            "${_selectedDate.year}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _selectedTime.format(context),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (source == null || destination == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select city and date'),
                          ),
                        );
                        return;
                      }
                      if (source == destination) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select different cities'),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        showRide = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 60),
                      maximumSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue[700],
                    ),
                    child: Text(
                      'Find a Ride',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (source == null || destination == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select city, date and time'),
                          ),
                        );
                        return;
                      }
                      if (source == destination) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select different cities'),
                          ),
                        );
                        return;
                      }

                      offerRideSheet(
                        context,
                        source.toString(),
                        destination.toString(),
                        selectedDateString,
                        selectedTimeString,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 60),
                      maximumSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blue),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Offer a Ride',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future:
                      showRide
                          ? FirebaseFirestore.instance
                              .collection('rides')
                              .where('source', isEqualTo: source)
                              .where('destination', isEqualTo: destination)
                              .where('date', isEqualTo: selectedDateString)
                              .get()
                          : FirebaseFirestore.instance
                              .collection('rides')
                              .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No rides found.'));
                    }

                    var a = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: a.length,
                      itemBuilder: (context, index) {
                        var ride = a[index];
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            ListTile(
                              shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              leading: CircleAvatar(
                                child: Image.asset('assets/images/person.png'),
                              ),
                              title: Text('Name'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ride['carModel'].toString()),
                                  Row(
                                    children: [
                                      Text(ride['seats'].toString()),
                                      SizedBox(width: 8),
                                      Container(
                                        color: Colors.grey,
                                        height: 15,
                                        width: 1,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Rs.${ride['price'].toString()}'),
                                      SizedBox(width: 8),
                                      Container(
                                        color: Colors.grey,
                                        height: 15,
                                        width: 1,
                                      ),
                                      SizedBox(width: 8),
                                      Text(ride['time'].toString()),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(60, 40),
                                  maximumSize: const Size(150, 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.blue[700],
                                ),
                                child: Text(
                                  'Book',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'My Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_rounded),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
