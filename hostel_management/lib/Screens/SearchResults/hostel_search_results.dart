import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/activity_main_card.dart';
import 'package:hostel_management/Widgets/hostels_main_card.dart';

class HostelSearchResults extends StatefulWidget {
  const HostelSearchResults({super.key});

  @override
  State<HostelSearchResults> createState() => _HostelSearchResultsState();
}

class _HostelSearchResultsState extends State<HostelSearchResults> {
  int selectedFilterIndex = 0; // Default first tag selected

  bool isSearchExpanded = false;
  int selectedTabIndex = 0; // 0 for Activities, 1 for Hostels
  late Animation<double> _fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          FadeTransition(opacity: _fadeAnimation, child: _buildMainContent()),

          // Search overlay
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: Column(
        children: [
          // Top bar with tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
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
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.13),
              ],
            ),
          ),
          // Filter tags (only show for Activities)
          if (selectedTabIndex == 0) _buildFilterTags(),

          // Content based on selected tab
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildHostelsGrid(),
            ),
          ),
          // Bottom navigation
          BottomNavigationBarComponent(
            isHomeActive: true,
            onItemSelected: (index) {
              // Handle navigation item selection
              print('Selected index: $index');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTags() {
    final size = MediaQuery.of(context).size;
    final tags = [
      'Whale Watching',
      'Diving',
      'Surf Lesson',
      'Yoga Class',
      'Ayurvedic Massage',
      'All',
      'Safari Tours',
      'Snorkeling',
      'Fishing Tours',
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: size.height * 0.055,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = selectedFilterIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilterIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF1A4D99) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF1A4D99), width: 1),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Color(0xFF1A4D99),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterTag(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        // color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF1A4D99), width: 1),
      ),
      child: InterTextWidget(
        text: text,
        fontSize: 13,
        color: Color(0xFF1A4D99),
        fontWeight: FontWeightConst.semiBold,
        letterSpacing: 0,
      ),
    );
  }

  Widget _buildActivitiesGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.5,
        children: [
          // In your screen or parent widget
          ActivityCard(
            rating: '4.8',
            imageUrl: 'assets/activity_card.png',
            price: '\$12',
            duration: '2-3 hrs',
            capacity: '11',
            activityName: 'Whale Watching Club Mirissa',
            location: 'Mirissa',
            trip: false,
            hasWhaleIcon: true,
            activityImage: 'assets/activity_ownwe.png',
            onTap: () {
              // Handle card tap
              print('Whale Watching Club Mirissa card tapped!');
              // Navigate to activity details page
            },
          ),
          ActivityCard(
            rating: '5.0',
            imageUrl: 'assets/activity_card.png',
            price: '\$25',
            duration: '4-5 hrs',
            capacity: '8',
            activityName: 'Charly\'s Surf School Club Mirissa',
            location: 'Mirissa',
            trip: false,
            hasWhaleIcon: false,
            activityImage: 'assets/activity_ownwe.png',
            onTap: () {
              // Handle card tap
              print('Charly\'s Surf School Club Mirissa card tapped!');
              // Navigate to activity details page
            },
          ),
          ActivityCard(
            rating: '4.6',
            imageUrl: 'assets/activity_card.png',
            price: '\$15',
            duration: '2-3 hrs',
            capacity: '15',
            activityName: 'Whale Watching Club Mirissa',
            location: 'Mirissa',
            trip: true,
            hasWhaleIcon: false,
            activityImage: 'assets/activity_ownwe.png',
            onTap: () {
              // Handle card tap
              print('Whale Watching Club Mirissa card tapped!');
              // Navigate to activity details page
            },
          ),
          ActivityCard(
            rating: '4.5',
            imageUrl: 'assets/activity_card.png',
            price: '\$30',
            duration: '3-4 hrs',
            capacity: '12',
            activityName: 'Diving School Club Mirissa',
            location: 'Mirissa',
            trip: false,
            hasWhaleIcon: false,
            activityImage: 'assets/activity_ownwe.png',
            onTap: () {
              // Handle card tap
              print('Diving School Club Mirissa card tapped!');
              // Navigate to activity details page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHostelsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 0.5,
      children: [
        // In your screen or parent widget
        HostelCard(
          rating: '4.8',
          imageUrl: 'assets/home_card.png',
          price1: '\$10',
          price2: '\$30',
          beds: '11',
          hostelName: 'Hostel Five Minus',
          location: 'Hangover Hostels',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            // Handle card tap
            print('Hostel Five Minus card tapped!');
            // Navigate to hostel details page
          },
        ),
        HostelCard(
          rating: '4.5',
          imageUrl: 'assets/home_card.png',
          price1: '\$15',
          price2: '\$45',
          beds: '8',
          hostelName: 'Hostel Five Minus',
          location: 'Hangover Hostels',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            // Handle card tap
            print('Hostel Five Minus card tapped!');
            // Navigate to hostel details page
          },
        ),
        HostelCard(
          rating: '4.6',
          imageUrl: 'assets/home_card.png',
          price1: '\$12',
          price2: '\$35',
          beds: '15',
          hostelName: 'JJ Hostel Mirissa',
          location: 'SATORI BEACH HOUSE',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            // Handle card tap
            print('JJ Hostel Mirissa card tapped!');
            // Navigate to hostel details page
          },
        ),
        HostelCard(
          rating: '4.9',
          imageUrl: 'assets/home_card.png',
          price1: '\$18',
          price2: '\$55',
          beds: '12',
          hostelName: 'JJ Hostel Mirissa',
          location: 'SATORI BEACH HOUSE',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            // Handle card tap
            print('JJ Hostel Mirissa card tapped!');
            // Navigate to hostel details page
          },
        ),
      ],
    );
  }
}
