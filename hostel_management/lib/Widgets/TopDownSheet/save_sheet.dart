import 'package:flutter/material.dart';
import 'package:hostel_management/Const/color_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/hostels_main_card.dart';

class SaveSheet {
  void showSaveSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Hostel card at the top
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.4 - 150),
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: screenHeight * 0.32,
                      child: HostelCard(
                        rating: '4.8',
                        imageUrl: 'assets/home_card.jpeg',
                        price1: '\$10',
                        price2: '\$30',
                        beds: '11',
                        hostelName: 'Hostel First',
                        location: 'Mirissa',
                        hostelImg: 'assets/hostel1st.png',
                        onTap: () {
                          Navigator.pop(context); // Close save sheet
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom sheet with save options
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: ColorConst.buttonbackgroundBlue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Saved section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "assets/home_card.jpeg", // Added 'assets/' prefix
                              width: size.width * 0.09,
                              height: size.height * 0.05,
                              fit: BoxFit.cover, // Added fit property
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback if image doesn't exist
                                return Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                  size: 20,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          const InterTextWidget(
                            text: 'Saved',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.bookmark,
                            color: Colors.black87,
                            size: size.width * 0.06,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Collections header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InterTextWidget(
                            text: 'Collections',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          Container(
                            width: size.width * 0.2,
                            height: size.height * 0.04,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.1, 0.5),
                                end: Alignment(0.9, 0.5),
                                colors: [Color(0xFF00B1D6), Color(0xFF00358D)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Center(
                              child: InterTextWidget(
                                text: 'Create',
                                fontSize: 14,
                                color: Color(0xFFFEFEFE),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Collections list
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          children: [
                            _buildCollectionItem(
                              'assets/home_card.jpeg',
                              'Hostels in Mirissa',
                              '12 places',
                            ),
                            _buildCollectionItem(
                              'assets/home_card.jpeg',
                              'Hostels in Sigiriya',
                              '5 places',
                            ),
                            _buildCollectionItem(
                              'assets/home_card.jpeg',
                              'Party Hostels',
                              '8 places',
                            ),
                            _buildCollectionItem(
                              'assets/home_card.jpeg',
                              'Cheap Hostels',
                              '15 places',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Start from bottom
            end: Offset.zero, // Slide up
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  // Helper function for collection items
  Widget _buildCollectionItem(String imagePath, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Collection image
          Container(
            width: 36,
            height: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.hotel, color: Colors.grey[600], size: 24),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Collection info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InterTextWidget(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                const SizedBox(height: 2),
                InterTextWidget(
                  text: subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]!,
                ),
              ],
            ),
          ),
          // Add icon
          Icon(Icons.add, color: Colors.grey[600], size: 20),
        ],
      ),
    );
  }
}
