import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime(2025, 4, 22);
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 0);
  final int _selectedIndex = 0;
  final List<String> cities = [
    "Abbottabad",
    "Ahmadpur East",
    "Ali Pur",
    "Arifwala",
    "Attock",
    "Bahawalnagar",
    "Bahawalpur",
    "Bannu",
    "Barkhan",
    "Batkhela",
    "Bhalwal",
    "Bhakkar",
    "Burewala",
    "Chakwal",
    "Charsadda",
    "Chiniot",
    "Chishtian",
    "Chitral",
    "Dadu",
    "Daska",
    "Dera Ghazi Khan",
    "Dera Ismail Khan",
    "Faisalabad",
    "Ghotki",
    "Gujranwala",
    "Gujrat",
    "Gwadar",
    "Hafizabad",
    "Hangu",
    "Haripur",
    "Hyderabad",
    "Islamabad",
    "Jacobabad",
    "Jafarabad",
    "Jalalpur Jattan",
    "Jaranwala",
    "Jatoi",
    "Jhang",
    "Jhelum",
    "Kamalia",
    "Kamoke",
    "Karachi",
    "Kasur",
    "Kharian",
    "Khairpur",
    "Khushab",
    "Kohat",
    "Kot Addu",
    "Kotli",
    "Lahore",
    "Larkana",
    "Layyah",
    "Lodhran",
    "Loralai",
    "Mandi Bahauddin",
    "Mansehra",
    "Mardan",
    "Mian Channu",
    "Mianwali",
    "Mirpur",
    "Mirpur Khas",
    "Multan",
    "Muzaffargarh",
    "Muzaffarabad",
    "Nawabshah",
    "Nowshera",
    "Okara",
    "Pakpattan",
    "Peshawar",
    "Quetta",
    "Rahim Yar Khan",
    "Rawalpindi",
    "Sadiqabad",
    "Sahiwal",
    "Sanghar",
    "Sargodha",
    "Sheikhupura",
    "Shikarpur",
    "Sialkot",
    "Sibi",
    "Skardu",
    "Sukkur",
    "Swabi",
    "Swat",
    "Tando Adam",
    "Tando Allahyar",
    "Tando Muhammad Khan",
    "Turbat",
    "Vehari",
    "Wah Cantt",
    "Zhob",
    "Ziarat",
  ];
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

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              DropdownSearch<String>(
                items: (f, c) => cities,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    controller: _fromController,
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
                onChanged: (value) {},
              ),

              SizedBox(height: 10),
              DropdownSearch<String>(
                items: (f, c) => cities,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    controller: _toController,
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
                onChanged: (value) {},
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
                          const Icon(Icons.calendar_today, size: 20),
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
                          const Icon(Icons.access_time, size: 20),
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
                    onPressed: () {},
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 60),
                      maximumSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue[700],
                    ),
                    child: Text(
                      'Offer a Ride',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ListTile(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 245, 245, 245),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                          leading: CircleAvatar(
                            child: Image.asset('assets/images/person.png'),
                          ),
                          title: Text('name'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('car'),
                              Row(
                                children: [
                                  Text('seats'),
                                  SizedBox(width: 8),
                                  Container(
                                    color: Colors.grey,
                                    height: 15,
                                    width: 1,
                                  ),
                                  SizedBox(width: 8),
                                  Text('time'),
                                  SizedBox(width: 8),
                                  Container(
                                    color: Colors.grey,
                                    height: 15,
                                    width: 1,
                                  ),
                                  SizedBox(width: 8),
                                  Text('price'),
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
