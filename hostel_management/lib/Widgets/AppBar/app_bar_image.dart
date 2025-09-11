import 'package:flutter/material.dart';
import 'package:hostel_management/Screens/AuthScreen/auth_screen.dart';
import 'package:hostel_management/Widgets/PageRoute/custom_page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogo extends StatelessWidget {
  const UserLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('UserLogo tapped!'); // Add this line
        final pref = await SharedPreferences.getInstance();
        pref.remove('userId');
        print('userId removed from SharedPreferences'); // Add this line
        Navigator.pushReplacement(context, ScalePageRoute(page: AuthScreen()));
        print('Navigation called'); // Add this line
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
            colors: [Color(0xFFA4EFFF), Color(0xFF00358D)],
          ),
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/img.jpeg'),
        ),
      ),
    );
  }
}
