import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';

class HostelCard extends StatelessWidget {
  final String rating;
  final String imageUrl;
  final String price1;
  final String price2;
  final String beds;
  final String hostelName;
  final String location;
  final String hostelImg;
  final VoidCallback? onTap; // Optional tap callback

  const HostelCard({
    super.key,
    required this.rating,
    required this.imageUrl,
    required this.price1,
    required this.price2,
    required this.beds,
    required this.hostelName,
    required this.location,
    required this.hostelImg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
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
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
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
                                text: 'Dorm',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeightConst.semiBold,
                              ),
                              SizedBox(width: 4),
                              InterTextWidget(
                                text: 'Private',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeightConst.semiBold,
                              ),
                              SizedBox(width: 4),
                              InterTextWidget(
                                text: 'Available',
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
                                price1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                price2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Image.asset(
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
                    Image.network(hostelImg, width: 30, height: 30),
                    SizedBox(width: 12),
                    // Hostel name
                    Expanded(
                      child: Text(
                        hostelName,
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
