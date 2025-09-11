import 'package:flutter/material.dart';
import 'package:hostel_management/Screens/HomeScreen/home_screen.dart';
import 'package:hostel_management/Screens/booking_screen.dart';
import 'package:hostel_management/Screens/profile_screen.dart';
import 'package:hostel_management/Widgets/BottomNavBar/bottom_nav_bar.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Saved Screen')),
          BottomNavigationBarComponent(
            currentIndex: 2,
            onItemSelected: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingScreen()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SavedScreen()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
