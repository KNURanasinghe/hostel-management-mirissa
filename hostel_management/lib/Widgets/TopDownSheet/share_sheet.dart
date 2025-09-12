import 'package:flutter/material.dart';
import 'package:hostel_management/Const/color_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/hostels_main_card.dart';

class ShareSheet {
  void showShareSheet(BuildContext context) {
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
                          Navigator.pop(context); // Close share sheet
                          // Add navigation to hostel details if needed
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom sheet with share options
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
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

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: InterTextWidget(
                                      text: 'Search',
                                      fontSize: 14,
                                      color: Color(0xFF1F2937),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Image.asset(
                                      'assets/search.png',
                                      width: 18,
                                      height: 18,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Container(
                            width: size.width * 0.09,
                            height: size.width * 0.09,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.50, -0.00),
                                end: Alignment(0.50, 1.00),
                                colors: [
                                  const Color(0xFF01ADD3),
                                  const Color(0xFF00388F),
                                ],
                              ),
                              shape: OvalBorder(),
                            ),
                            child: Image.asset(
                              'assets/PlusMath.png',
                              width: 33,
                              height: 33,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Contact avatars (first row)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildContactAvatar(
                            'assets/sarah_avatar.png',
                            'Sarah',
                          ),
                          _buildContactAvatar('assets/mike_avatar.png', 'Mike'),
                          _buildContactAvatar('assets/alex_avatar.png', 'Alex'),
                          _buildContactAvatar('assets/emma_avatar.png', 'Emma'),
                          _buildContactAvatar(
                            'assets/david_avatar.png',
                            'David',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Contact avatars (second row)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildContactAvatar(
                            'assets/sarah_avatar2.png',
                            'Sarah',
                          ),
                          _buildContactAvatar(
                            'assets/mike_avatar2.png',
                            'Mike',
                          ),
                          _buildContactAvatar(
                            'assets/alex_avatar2.png',
                            'Alex',
                          ),
                          _buildContactAvatar(
                            'assets/emma_avatar2.png',
                            'Emma',
                          ),
                          _buildContactAvatar(
                            'assets/david_avatar2.png',
                            'David',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Share Via text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InterTextWidget(
                          text: 'Share Via',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Share options
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildShareOption(Icons.copy, 'Copy'),
                          _buildShareOption(Icons.share, 'Share'),
                          _buildShareOption(
                            Icons.message,
                            'WhatsApp',
                            color: Colors.green,
                          ),
                          _buildShareOption(
                            Icons.facebook,
                            'Facebook',
                            color: Colors.blue,
                          ),
                          _buildShareOption(
                            Icons.camera_alt,
                            'Instagram',
                            color: Colors.purple,
                          ),
                          _buildShareOption(Icons.more_horiz, 'More'),
                        ],
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
        final curvedValue = Curves.easeOut.transform(anim1.value) - 1.0;
        return Transform.translate(
          offset: Offset(0, curvedValue * -50),
          child: child,
        );
      },
    );
  }

  // Helper function for contact avatars
  Widget _buildContactAvatar(String imagePath, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[300],
          backgroundImage: AssetImage(imagePath),
          onBackgroundImageError: (exception, stackTrace) {
            // Handle image loading error - show placeholder
          },
          child:
              imagePath.isEmpty
                  ? InterTextWidget(
                    text: name.isNotEmpty ? name[0].toUpperCase() : '?',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                  : null,
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }

  // Helper function for share options
  Widget _buildShareOption(IconData icon, String label, {Color? color}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: color ?? Colors.black54, size: 22),
        ),
        const SizedBox(height: 6),
        InterTextWidget(
          text: label,
          fontSize: 11,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
