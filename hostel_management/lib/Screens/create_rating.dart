import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/gradient_button.dart';

class CreateRating extends StatefulWidget {
  const CreateRating({super.key});

  @override
  State<CreateRating> createState() => _CreateRatingState();
}

class _CreateRatingState extends State<CreateRating> {
  int overallRating = 0;
  Map<String, int> categoryRatings = {
    'Value for money': 0,
    'Cleanliness': 0,
    'Staff': 0,
    'Location': 0,
    'Facilities': 0,
    'Comfort': 0,
  };

  String selectedTravelReason = '';
  String selectedCompanion = '';

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/Profile2.png'),
        ),
        const SizedBox(width: 12),
        const Text(
          "Hostel First Mirissa",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InterTextWidget(
          text: "4.8",
          fontSize: 32,
          color: Color(0xFF171725),
          fontWeight: FontWeightConst.semiBold,
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return Icon(
              index < 4 ? Icons.star_rounded : Icons.star_border_rounded,
              color: Colors.amber,
              size: 24,
            );
          }),
        ),
        const SizedBox(height: 5),
        // const Text(
        //   "Based on 532 review",
        //   style: TextStyle(fontSize: 11, color: Colors.grey),
        // ),
        InterTextWidget(
          text: 'Based on 532 review',
          fontSize: 12,
          color: Color(0xFF9CA4AB),
          fontWeight: FontWeightConst.medium,
        ),
      ],
    );
  }

  Widget _buildRatingBreakdown() {
    final Map<int, double> ratings = {1: 0.1, 2: 0.15, 3: 0.25, 4: 0.4, 5: 0.6};
    return Padding(
      padding: const EdgeInsets.only(left: 45.0),
      child: Column(
        children: List.generate(5, (index) {
          final star = 1 + index;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            child: Row(
              children: [
                Text(
                  '$star',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    value: ratings[star],
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue[800]!,
                    ),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Column(
      //     children: [
      //       Text(
      //         'Hostel First Mirissa',
      //         style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: Colors.black,
      //         ),
      //       ),
      //       Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Text(
      //             '4.4',
      //             style: TextStyle(
      //               fontSize: 14,
      //               fontWeight: FontWeight.w500,
      //               color: Colors.black54,
      //             ),
      //           ),
      //           SizedBox(width: 4),
      //           ...List.generate(5, (index) {
      //             return Icon(
      //               index < 4 ? Icons.star : Icons.star_border,
      //               size: 16,
      //               color: Colors.orange,
      //             );
      //           }),
      //         ],
      //       ),
      //     ],
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  // Rate and Review Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildRatingSummary()),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Expanded(flex: 3, child: _buildRatingBreakdown()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //rate and review section
                  Divider(height: 3, color: Color(0xff9CA1AA)),
                  SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rate and Review',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person, color: Colors.grey[600]),
                          ),
                          SizedBox(width: 12),
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              color: Color(0xffE3E9ED),
                              size: 24,
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Divider(height: 3, color: Color(0xff9CA1AA)),
                  SizedBox(height: 16),

                  // Rate your experience
                  Text(
                    'Rate your experience',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Category Ratings
                  ...categoryRatings.entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(entry.key),
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      categoryRatings[entry.key] = index + 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      index < entry.value
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 8),

                  TextFormField(
                    //controller: _commentController,
                    minLines: 3,
                    maxLines: null, // Allows unlimited lines
                    decoration: InputDecoration(
                      // labelText: 'Leave a comment',
                      hintText: 'Leave a comment here...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[600]!),
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Added to match the enabled border
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Upload photos and videos
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Upload photos and videos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  Text(
                    'What kind of trip was it?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Trip type selection
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectableChipkind(
                          'Business',
                          selectedTravelReason == 'Business',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectableChipkind(
                          'Holiday',
                          selectedTravelReason == 'Holiday',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // What kind of trip was it?
                  Text(
                    'Who did you travel with?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Trip type selection
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectableChip(
                          'Solo',
                          selectedTravelReason == 'Solo',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectableChip(
                          'Couple',
                          selectedTravelReason == 'Couple',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectableChip(
                          'Family',
                          selectedTravelReason == 'Family',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectableChip(
                          'Friends',
                          selectedTravelReason == 'Friends',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  // Post Review Button
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Handle review submission
                  //       _submitReview();
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blue[600],
                  //       foregroundColor: Colors.white,
                  //       padding: EdgeInsets.symmetric(vertical: 16),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       elevation: 0,
                  //     ),
                  //     child: Text(
                  //       'Post Review',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      _submitReview();
                    },
                    child: GradientButton(text: 'Post Review'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTravelReason = isSelected ? '' : label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue[600] : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableChipkind(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTravelReason = isSelected ? '' : label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue[600] : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Value for money':
        return Icons.attach_money;
      case 'Cleanliness':
        return Icons.cleaning_services_outlined;
      case 'Staff':
        return Icons.person_outline;
      case 'Location':
        return Icons.location_on_outlined;
      case 'Facilities':
        return Icons.business_outlined;
      case 'Comfort':
        return Icons.hotel_outlined;
      default:
        return Icons.star_outline;
    }
  }

  void _submitReview() {
    // Validate that at least overall rating is provided
    if (overallRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide an overall rating'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Handle review submission logic here
    print('Overall Rating: $overallRating');
    print('Category Ratings: $categoryRatings');
    print('Travel Reason: $selectedTravelReason');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back or to next screen
    Navigator.pop(context);
  }
}
