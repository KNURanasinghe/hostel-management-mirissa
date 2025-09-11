import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  final int currentIndex; // Changed from isHomeActive
  final Function(int)? onItemSelected;

  const BottomNavigationBarComponent({
    super.key,
    this.currentIndex = 0, // Default to home (index 0)
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(
            'assets/bottom_nav/house.png',
            'Home',
            0,
            currentIndex == 0 ? true : false, // Check if current index is 0
          ),
          _buildBottomNavItem(
            'assets/bottom_nav/booking.png',
            'Booking', // Add text for when active
            1,
            currentIndex == 1 ? true : false, // Check if current index is 1
          ),
          _buildBottomNavItem(
            'assets/bottom_nav/save.png',
            'Saved', // Add text for when active
            2,
            currentIndex == 2 ? true : false, // Check if current index is 2
          ),
          _buildBottomNavItem(
            'assets/bottom_nav/profile.png',
            'Profile', // Add text for when active
            3,
            currentIndex == 3 ? true : false, // Check if current index is 3
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    String path,
    String text,
    int index,
    bool isActive,
  ) {
    print('isActive: $isActive, index: $index text: $text');
    return GestureDetector(
      onTap: () => onItemSelected?.call(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Image(
              image: AssetImage(path),
              width: 24,
              height: 24,
              color: isActive ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 4),
            if (isActive &&
                text.isNotEmpty) // Only show text if active and text exists
              InterTextWidget(
                text: text,
                fontSize: 10,
                color: isActive ? Colors.blue : Colors.grey,
                fontWeight: FontWeightConst.semiBold,
              ),
          ],
        ),
      ),
    );
  }
}
