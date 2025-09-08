import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/Const/color_const.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Screens/ViewScreen/view_screen.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_image.dart';
import 'package:hostel_management/Widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:hostel_management/Widgets/Calender/calender_pop_up.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/activity_main_card.dart';
import 'package:hostel_management/Widgets/hostels_main_card.dart'
    show HostelCard;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectedFilterIndex = 0; // Default first tag selected

  bool isSearchExpanded = false;
  int selectedTabIndex = 0; // 0 for Activities, 1 for Hostels
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _calendarAnimationController;
  late Animation<double> _calendarScaleAnimation;
  late Animation<Offset> _calendarSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _calendarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _calendarScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _calendarAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _calendarSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _calendarAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarAnimationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showAnimatedCalendar() async {
    // Start the animation
    _calendarAnimationController.forward();

    // Show calendar with custom animation
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlideTransition(
          position: _calendarSlideAnimation,
          child: ScaleTransition(
            scale: _calendarScaleAnimation,
            child: CalendarPopup(
              onApply: (checkIn, checkOut, guests, rooms) {
                // Handle the selected values
                print('Check-in: $checkIn');
                print('Check-out: $checkOut');
                print('Guests: $guests');
                print('Rooms: $rooms');

                // Reset animation
                _calendarAnimationController.reset();
              },
              onCancel: () {
                print('Calendar cancelled');
                // Reset animation
                _calendarAnimationController.reset();
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  void toggleSearch() {
    setState(() {
      isSearchExpanded = !isSearchExpanded;
      if (isSearchExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
      }
    });
  }

  void selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 👈 Prevents navbar from moving up
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          FadeTransition(opacity: _fadeAnimation, child: _buildMainContent()),
          // Search overlay
          if (isSearchExpanded)
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildSearchOverlay(),
            ),
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
                GestureDetector(
                  onTap: () => selectTab(0),
                  child: InterTextWidget(
                    text: 'Activities',
                    fontSize: 20,
                    fontWeight: FontWeightConst.semiBold,
                    color:
                        selectedTabIndex == 0
                            ? Color(0xFF1F1B1B)
                            : Color(0xFFAB9E9E),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                GestureDetector(
                  onTap: () => selectTab(1),
                  child: InterTextWidget(
                    text: 'Hostels',
                    fontSize: 20,
                    fontWeight: FontWeightConst.semiBold,
                    color:
                        selectedTabIndex == 1
                            ? Color(0xFF1F1B1B)
                            : Color(0xFFAB9E9E),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: toggleSearch,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: AssetImage('assets/search.png'),
                      width: 24,
                      height: 24,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter tags (only show for Activities)
          if (selectedTabIndex == 0) _buildFilterTags(),

          // Content based on selected tab
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:
                  selectedTabIndex == 0
                      ? _buildActivitiesGrid()
                      : _buildHostelsGrid(),
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
      'All',
      'Whale Watching',
      'Diving',
      'Surf Lesson',
      'Yoga Class',
      'Ayurvedic Massage',

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
                  color:
                      isSelected
                          ? ColorConst.buttonbackgroundBlue
                          : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorConst.buttonbackgroundBlue,
                    width: 1,
                  ),
                ),
                child: InterTextWidget(
                  text: tag,
                  fontSize: 13,
                  color: isSelected ? Colors.white : Color(0xFF1A4D99),
                  fontWeight: FontWeightConst.semiBold,

                  letterSpacing: 0,
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
            imageUrl: 'assets/act_surf.png',
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
            imageUrl: 'assets/act_whale.png',
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
            imageUrl: 'assets/act_div.png',
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
                    (context) =>
                        ViewScreen(backgroundImage: 'assets/home_card.png'),
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
                    (context) => ViewScreen(backgroundImage: 'assets/ab.png'),
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
                    (context) => ViewScreen(backgroundImage: 'assets/c.jpeg'),
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
                    (context) => ViewScreen(backgroundImage: 'assets/d.jpeg'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchOverlay() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),

              child: Row(
                children: [
                  UserLogo(),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        onTap: () {
                          _searchController.clear;
                          // In your search icon onTap:
                          _showAnimatedCalendar();
                        },
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorConst.textgray,
                            fontWeight: FontWeightConst.semiBold,
                          ),
                          hintText:
                              selectedTabIndex == 0
                                  ? 'search for activities'
                                  : 'search for places or property',
                          prefixIcon: Image(
                            image: AssetImage('assets/search.png'),
                            width: 20,
                            height: 20,
                            color: ColorConst.textgray,
                          ),
                          suffixIcon: Image(
                            image: AssetImage('assets/location_48.png'),
                            width: 20,
                            height: 20,
                            color: ColorConst.textgray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: toggleSearch,
                    child: Icon(Icons.close, color: Colors.black87, size: 24),
                  ),
                ],
              ),
            ),
            // Filter tags for activities in search
            if (selectedTabIndex == 0) _buildFilterTags(),
            // Search results
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child:
                    selectedTabIndex == 0
                        ? _buildActivitiesGrid()
                        : _buildHostelsGrid(),
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
      ),
    );
  }
}
