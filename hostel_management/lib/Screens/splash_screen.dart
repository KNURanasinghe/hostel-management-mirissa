import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <-- Add this
import 'package:hostel_management/LocalServices/onesignal_service.dart';
import 'package:hostel_management/LocalServices/shared_pref_service.dart';
import 'package:hostel_management/Screens/HomeScreen/home_screen.dart';
import 'package:hostel_management/Screens/OnBoardScreens/on_board_screen.dart';
import 'package:hostel_management/Widgets/PageRoute/custom_page_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? deviceID = '';
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      navigateToNextScreen();
      getdeviceId();
    });
  }

  void navigateToNextScreen() async {
    final userid = await SharedPrefService.getUserId();
    if (userid != null) {
      Navigator.pushReplacement(
        context,
        ScalePageRoute(page: const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        ScalePageRoute(page: const OnBoardScreen()),
      );
    }
  }

  Future<void> getdeviceId() async {
    try {
      deviceID = await OneSignalService.instance.getDeviceId();
      print('Device ID: $deviceID');
    } catch (e) {
      print('Error getting device ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/splash_logo.png')
                .animate(
                  onPlay: (controller) => controller.forward(),
                ) // repeat loop
                .scale(
                  duration: 800.ms,
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.9, 1.9),
                  curve: Curves.ease,
                ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom,
        ),
        child: Text(
          'Copy Rights by Book Now',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
