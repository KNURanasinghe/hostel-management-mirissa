import 'package:flutter/material.dart';
import 'package:hostel_management/Screens/HomeScreen/home_screen.dart';
import 'package:hostel_management/Screens/booking_screen.dart';
import 'package:hostel_management/Screens/saved_screen.dart';
import 'package:hostel_management/Widgets/BottomNavBar/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Profile Screen')),
          BottomNavigationBarComponent(
            currentIndex: 3,
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
