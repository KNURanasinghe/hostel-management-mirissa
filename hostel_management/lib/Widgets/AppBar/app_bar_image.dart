import 'package:flutter/material.dart';

class UserLogo extends StatelessWidget {
  const UserLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
