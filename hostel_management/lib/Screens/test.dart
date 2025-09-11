import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_image.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_user_set.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/filter_tags.dart';
import 'package:hostel_management/Widgets/verticle_action_button.dart';

class TestScreen extends StatefulWidget {
  final String backgroundImage;
  final String hostelName;
  final String description;
  final String location;
  final String price1;
  final String price2;
  final String availability;
  final String hostelImage;

  const TestScreen({
    super.key,
    required this.backgroundImage,
    required this.hostelName,
    required this.description,
    required this.location,
    required this.price1,
    required this.price2,
    required this.availability,
    required this.hostelImage,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(widget.backgroundImage, fit: BoxFit.cover),
          ),

          // Content Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hostel Name
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            widget.hostelImage,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.hostelName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Description with Read More
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterTextWidget(
                          text:
                              showFullDescription
                                  ? '${widget.description} '
                                  : '${widget.description.substring(0, 30)}...',
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeightConst.semiBold,
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showFullDescription = !showFullDescription;
                            });
                          },
                          child: Text(
                            showFullDescription ? 'Read less' : 'Read More',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Location and Availability
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 21,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    InterTextWidget(
                                      text: widget.location,
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeightConst.medium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          widget.availability,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Price and Choose Room Button
                    Row(
                      children: [
                        // Discounted Price
                        Text(
                          widget.price1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Original Price
                        Text(
                          widget.price2,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        // Choose Room Button
                        ElevatedButton(
                          onPressed: () {
                            // Handle room selection
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Choose Room',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Actions Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 20,
            child: VerticleActionButton(),
          ),
          // User Logo
          Positioned(top: 40, left: 20, child: UserLogo()),

          //Filter Tags
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width * 0.23,
            child: FilterTags(isNotBlack: false),
          ),

          // AppBar User Set
          Positioned(
            top: 40,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppBarUserSet(),
            ),
          ),
        ],
      ),
    );
  }
}
