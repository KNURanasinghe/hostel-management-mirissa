import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';

class ActivityCard extends StatelessWidget {
  final String rating;
  final String imageUrl;
  final String price;
  final String duration;
  final String capacity;
  final String activityName;
  final String location;
  final bool trip;
  final bool hasWhaleIcon;
  final String activityImage;
  final VoidCallback? onTap; // Optional tap callback

  const ActivityCard({
    Key? key,
    required this.rating,
    required this.imageUrl,
    required this.price,
    required this.duration,
    required this.capacity,
    required this.activityName,
    required this.location,
    required this.trip,
    required this.hasWhaleIcon,
    required this.activityImage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              // Image section
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    // Main image
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(imageUrl, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: SizedBox(
                        width: 63,
                        height: 20,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
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
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 2,
                                      top: 4.67,
                                      child: Container(
                                        width: 15.33,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "https://placehold.co/15x10",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/20x20",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFEEEEEE),
                                    ),
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                                child: Image.asset('assets/img.png'),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/20x20",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFEEEEEE),
                                    ),
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                                child: Image.asset('assets/img.png'),
                              ),
                            ),
                            Positioned(
                              left: 43,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://placehold.co/20x20",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFEEEEEE),
                                    ),
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                                child: Image.asset('assets/img.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Rating badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 14),
                            SizedBox(width: 4),
                            Text(
                              rating,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Tags overlay on image
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tags row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InterTextWidget(
                                text: 'P/P',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeightConst.semiBold,
                              ),
                              SizedBox(width: 4),
                              InterTextWidget(
                                text: 'Duration',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeightConst.semiBold,
                              ),
                              SizedBox(width: 4),
                              InterTextWidget(
                                text: 'Include',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeightConst.semiBold,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Price row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                price,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/waiting_time.png',
                                    width: 8,
                                    height: 12,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    duration,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 4),
                              trip
                                  ? Image.asset(
                                    'assets/trip_vehicle.png',
                                    width: 50,
                                    height: 20,
                                  )
                                  : hasWhaleIcon
                                  ? Image.asset(
                                    'assets/surfe.png',
                                    width: 50,
                                    height: 20,
                                  )
                                  : Image.asset(
                                    'assets/Cutlery.png',
                                    width: 50,
                                    height: 20,
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // White bottom section
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  children: [
                    // Logo/Avatar
                    Image.asset(activityImage, width: 30, height: 30),
                    SizedBox(width: 12),
                    // Hostel name
                    Expanded(
                      child: Text(
                        activityName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
