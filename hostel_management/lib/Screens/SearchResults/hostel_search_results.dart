import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Screens/ViewScreen/view_screen.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_user_set.dart';
import 'package:hostel_management/Widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/filter_tags.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          _buildMainContent(),

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
            padding: EdgeInsets.only(left: 20, right: 20, top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                InterTextWidget(
                  text: 'Hostels Mirissa',
                  fontSize: 20,
                  color: Color(0xFF030303),
                  fontWeight: FontWeightConst.semiBold,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                AppBarUserSet(),
              ],
            ),
          ),
          // Filter tags (only show for Activities)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildFilterTags(),
          ),

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
    return FilterTags();
  }

  Widget _buildHostelsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 0.5,
      children: [
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ViewScreen(
                      backgroundImage: 'assets/home_card.png',
                      hostelName: 'Hostel First Mirissa',
                      description: 'Lorem ipsum alviflagrideridat.',
                      location: 'Mirissa',
                      price1: '\$10',
                      price2: '\$30',
                      availability: '48 (532) Available',
                      hostelImage: 'assets/hostel1st.png',
                    ),
              ),
            );
          },
        ),
        HostelCard(
          rating: '4.5',
          imageUrl: 'assets/ab.png',
          price1: '\$15',
          price2: '\$45',
          beds: '8',
          hostelName: 'Hostel Five Minus',
          location: 'Hangover Hostels',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ViewScreen(
                      backgroundImage: 'assets/ab.png',
                      hostelName: 'Hostel First Mirissa',
                      description: 'Lorem ipsum alviflagrideridat.',
                      location: 'Mirissa',
                      price1: '\$10',
                      price2: '\$30',
                      availability: '48 (532) Available',
                      hostelImage: 'assets/hostel1st.png',
                    ),
              ),
            );
          },
        ),
        HostelCard(
          rating: '4.6',
          imageUrl: 'assets/c.jpeg',
          price1: '\$12',
          price2: '\$35',
          beds: '15',
          hostelName: 'JJ Hostel Mirissa',
          location: 'SATORI BEACH HOUSE',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ViewScreen(
                      backgroundImage: 'assets/c.jpeg',
                      hostelName: 'Hostel First Mirissa',
                      description: 'Lorem ipsum alviflagrideridat.',
                      location: 'Mirissa',
                      price1: '\$10',
                      price2: '\$30',
                      availability: '48 (532) Available',
                      hostelImage: 'assets/hostel1st.png',
                    ),
              ),
            );
          },
        ),
        HostelCard(
          rating: '4.9',
          imageUrl: 'assets/d.jpeg',
          price1: '\$18',
          price2: '\$55',
          beds: '12',
          hostelName: 'JJ Hostel Mirissa',
          location: 'SATORI BEACH HOUSE',
          hostelImg: 'assets/hostel1st.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ViewScreen(
                      backgroundImage: 'assets/d.jpeg',
                      hostelName: 'Hostel First Mirissa',
                      description: 'Lorem ipsum alviflagrideridat.',
                      location: 'Mirissa',
                      price1: '\$10',
                      price2: '\$30',
                      availability: '48 (532) Available',
                      hostelImage: 'assets/hostel1st.png',
                    ),
              ),
            );
          },
        ),
      ],
    );
  }
}
