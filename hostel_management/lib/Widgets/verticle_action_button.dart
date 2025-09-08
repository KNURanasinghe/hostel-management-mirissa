import 'package:flutter/material.dart';

class VerticleActionButton extends StatelessWidget {
  const VerticleActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            width: 43,
            height: 43,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                'assets/locations.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 17),
        ClipOval(
          child: Container(
            width: 43,
            height: 43,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                'assets/edit.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 17),
        ClipOval(
          child: Container(
            width: 43,
            height: 43,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                'assets/share.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 17),
        ClipOval(
          child: Container(
            width: 43,
            height: 43,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                'assets/save_reals.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
