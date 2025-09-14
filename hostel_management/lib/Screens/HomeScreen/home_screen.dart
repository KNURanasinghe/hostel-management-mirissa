import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/Const/color_const.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Screens/ViewScreen/view_screen.dart';
import 'package:hostel_management/Screens/booking_screen.dart';
import 'package:hostel_management/Screens/profile_screen.dart';
import 'package:hostel_management/Screens/saved_screen.dart';
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
  int selectedFilterIndex = 0;
  bool isSearchExpanded = false;
  int selectedTabIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  // PageView controllers for both normal and search modes
  late PageController _mainPageController;
  late PageController _searchPageController;

  late AnimationController _calendarAnimationController;
  late Animation<double> _calendarScaleAnimation;
  late Animation<Offset> _calendarSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize PageControllers
    _mainPageController = PageController(initialPage: selectedTabIndex);
    _searchPageController = PageController(initialPage: selectedTabIndex);

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
    _calendarAnimationController.dispose();
    _searchController.dispose();
    _mainPageController.dispose();
    _searchPageController.dispose();
    super.dispose();
  }

  void _showAnimatedCalendar() async {
    _calendarAnimationController.forward();

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
                print('Check-in: $checkIn');
                print('Check-out: $checkOut');
                print('Guests: $guests');
                print('Rooms: $rooms');
                _calendarAnimationController.reset();
              },
              onCancel: () {
                print('Calendar cancelled');
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
      if (!isSearchExpanded) {
        _searchController.clear();
      }
    });

    // Sync the search page controller with main page controller
    if (isSearchExpanded) {
      _searchPageController.animateToPage(
        selectedTabIndex,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  void selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      selectedFilterIndex = 0; // Reset filter when switching tabs
    });

    // Animate both page controllers
    _mainPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    if (isSearchExpanded) {
      _searchPageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Handle page change from swipe in main content
  void _onMainPageChanged(int index) {
    setState(() {
      selectedTabIndex = index;
      selectedFilterIndex = 0;
    });

    // Sync search page controller if search is expanded
    if (isSearchExpanded) {
      _searchPageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  // Handle page change from swipe in search overlay
  void _onSearchPageChanged(int index) {
    setState(() {
      selectedTabIndex = index;
      selectedFilterIndex = 0;
    });

    // Sync main page controller
    _mainPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content with fade animation
          _buildMainContent()
              .animate(target: isSearchExpanded ? 0 : 1)
              .fadeIn(duration: 350.ms, curve: Curves.easeInOut)
              .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),

          // Search overlay with smooth entrance
          if (isSearchExpanded)
            _buildSearchOverlay()
                .animate()
                .fadeIn(duration: 300.ms, curve: Curves.easeOut)
                .slideY(
                  begin: -0.1,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .scale(
                  begin: const Offset(0.98, 0.98),
                  end: const Offset(1, 1),
                  duration: 350.ms,
                  curve: Curves.easeOut,
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
          _buildTabBar(),

          // Content with PageView for swipe functionality
          Expanded(
            child: Column(
              children: [
                // Filter tags (only show for Activities)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height:
                      selectedTabIndex == 0
                          ? MediaQuery.of(context).size.height * 0.065
                          : 0,
                  child:
                      selectedTabIndex == 0
                          ? _buildFilterTags()
                              .animate()
                              .slideY(
                                begin: -0.5,
                                duration: 300.ms,
                                curve: Curves.easeOut,
                              )
                              .fadeIn(duration: 250.ms)
                          : Container(),
                ),

                // PageView for swipeable content
                Expanded(
                  child: PageView(
                    controller: _mainPageController,
                    onPageChanged: _onMainPageChanged,
                    physics:
                        AlwaysScrollableScrollPhysics(), // Ensure swipe works
                    children: [
                      // Activities page
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _buildActivitiesGrid(),
                      ),
                      // Hostels page
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _buildHostelsGrid(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          UserLogo()
              .animate()
              .scale(delay: 100.ms, duration: 200.ms)
              .fadeIn(delay: 100.ms),
          SizedBox(width: MediaQuery.of(context).size.width * 0.13),

          // Activities tab
          GestureDetector(
            onTap: () => selectTab(0),
            child: Column(
                  children: [
                    InterTextWidget(
                      text: 'Activities',
                      fontSize: 20,
                      fontWeight: FontWeightConst.semiBold,
                      color:
                          selectedTabIndex == 0
                              ? Color(0xFF1F1B1B)
                              : Color(0xFFAB9E9E),
                    ),
                    SizedBox(height: 4),
                    Container(
                          height: 2,
                          width: 60,
                          decoration: BoxDecoration(
                            color:
                                selectedTabIndex == 0
                                    ? Color(0xFF1F1B1B)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        )
                        .animate(target: selectedTabIndex == 0 ? 1 : 0)
                        .scaleX(
                          begin: 0,
                          end: 1,
                          duration: 200.ms,
                          curve: Curves.easeOut,
                        ),
                  ],
                )
                .animate(target: selectedTabIndex == 0 ? 1 : 0)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  duration: 150.ms,
                ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),

          // Hostels tab
          GestureDetector(
            onTap: () => selectTab(1),
            child: Column(
                  children: [
                    InterTextWidget(
                      text: 'Hostels',
                      fontSize: 20,
                      fontWeight: FontWeightConst.semiBold,
                      color:
                          selectedTabIndex == 1
                              ? Color(0xFF1F1B1B)
                              : Color(0xFFAB9E9E),
                    ),
                    SizedBox(height: 4),
                    Container(
                          height: 2,
                          width: 50,
                          decoration: BoxDecoration(
                            color:
                                selectedTabIndex == 1
                                    ? Color(0xFF1F1B1B)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        )
                        .animate(target: selectedTabIndex == 1 ? 1 : 0)
                        .scaleX(
                          begin: 0,
                          end: 1,
                          duration: 200.ms,
                          curve: Curves.easeOut,
                        ),
                  ],
                )
                .animate(target: selectedTabIndex == 1 ? 1 : 0)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  duration: 150.ms,
                ),
          ),
          Spacer(),

          // Search icon
          GestureDetector(
            onTap: toggleSearch,
            child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image(
                    image: AssetImage('assets/search.png'),
                    width: 24,
                    height: 24,
                    color: Color(0xFF666666),
                  ),
                )
                .animate()
                .scale(duration: 150.ms, curve: Curves.easeOut)
                .then()
                .shake(hz: 2, duration: 200.ms),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
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
                        child: Center(
                          child: InterTextWidget(
                            text: tag,
                            fontSize: 13,
                            color:
                                isSelected ? Colors.white : Color(0xFF1A4D99),
                            fontWeight: FontWeightConst.semiBold,
                            letterSpacing: 0,
                          ),
                        ),
                      )
                      .animate(target: isSelected ? 1 : 0)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1.02, 1.02),
                        duration: 200.ms,
                        curve: Curves.easeOut,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.02, 1.02),
                        end: const Offset(1, 1),
                        duration: 100.ms,
                      ),
                )
                .animate(delay: Duration(milliseconds: 50 * index))
                .slideX(begin: 0.3, duration: 400.ms, curve: Curves.easeOutBack)
                .fadeIn(duration: 300.ms),
          );
        },
      ),
    );
  }

  Widget _buildActivitiesGrid() {
    final activities = [
      {
        'rating': '4.8',
        'imageUrl': 'assets/activity_card.png',
        'price': '\$12',
        'duration': '2-3 hrs',
        'capacity': '11',
        'activityName': 'Whale Watching Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': true,
      },
      {
        'rating': '5.0',
        'imageUrl': 'assets/act_surf.png',
        'price': '\$25',
        'duration': '4-5 hrs',
        'capacity': '8',
        'activityName': 'Charly\'s Surf School Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': false,
      },
      {
        'rating': '4.6',
        'imageUrl': 'assets/act_whale.png',
        'price': '\$15',
        'duration': '2-3 hrs',
        'capacity': '15',
        'activityName': 'Whale Watching Club Mirissa',
        'location': 'Mirissa',
        'trip': true,
        'hasWhaleIcon': false,
      },
      {
        'rating': '4.5',
        'imageUrl': 'assets/act_div.png',
        'price': '\$30',
        'duration': '3-4 hrs',
        'capacity': '12',
        'activityName': 'Diving School Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': false,
      },
      {
        'rating': '4.8',
        'imageUrl': 'assets/activity_card.png',
        'price': '\$12',
        'duration': '2-3 hrs',
        'capacity': '11',
        'activityName': 'Whale Watching Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': true,
      },
      {
        'rating': '5.0',
        'imageUrl': 'assets/act_surf.png',
        'price': '\$25',
        'duration': '4-5 hrs',
        'capacity': '8',
        'activityName': 'Charly\'s Surf School Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': false,
      },
      {
        'rating': '4.6',
        'imageUrl': 'assets/act_whale.png',
        'price': '\$15',
        'duration': '2-3 hrs',
        'capacity': '15',
        'activityName': 'Whale Watching Club Mirissa',
        'location': 'Mirissa',
        'trip': true,
        'hasWhaleIcon': false,
      },
      {
        'rating': '4.5',
        'imageUrl': 'assets/act_div.png',
        'price': '\$30',
        'duration': '3-4 hrs',
        'capacity': '12',
        'activityName': 'Diving School Club Mirissa',
        'location': 'Mirissa',
        'trip': false,
        'hasWhaleIcon': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.5,
        ),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return ActivityCard(
                rating: activity['rating'] as String,
                imageUrl: activity['imageUrl'] as String,
                price: activity['price'] as String,
                duration: activity['duration'] as String,
                capacity: activity['capacity'] as String,
                activityName: activity['activityName'] as String,
                location: activity['location'] as String,
                trip: activity['trip'] as bool,
                hasWhaleIcon: activity['hasWhaleIcon'] as bool,
                activityImage: 'assets/activity_ownwe.png',
                onTap: () {
                  print('${activity['activityName']} card tapped!');
                },
              )
              .animate(delay: Duration(milliseconds: 100 * index))
              .slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOutBack)
              .fadeIn(
                duration: 400.ms,
                delay: Duration(milliseconds: 50 * index),
              );
        },
      ),
    );
  }

  Widget _buildHostelsGrid() {
    final hostels = [
      {
        'rating': '4.8',
        'imageUrl': 'assets/home_card.png',
        'price1': '\$10',
        'price2': '\$30',
        'beds': '11',
        'hostelName': 'Hostel Five Minus',
        'location': 'Hangover Hostels',
      },
      {
        'rating': '4.5',
        'imageUrl': 'assets/ab.png',
        'price1': '\$15',
        'price2': '\$45',
        'beds': '8',
        'hostelName': 'Hostel Five Minus',
        'location': 'Hangover Hostels',
      },
      {
        'rating': '4.6',
        'imageUrl': 'assets/c.jpeg',
        'price1': '\$12',
        'price2': '\$35',
        'beds': '15',
        'hostelName': 'JJ Hostel Mirissa',
        'location': 'SATORI BEACH HOUSE',
      },
      {
        'rating': '4.9',
        'imageUrl': 'assets/d.jpeg',
        'price1': '\$18',
        'price2': '\$55',
        'beds': '12',
        'hostelName': 'JJ Hostel Mirissa',
        'location': 'SATORI BEACH HOUSE',
      },
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.5,
      ),
      itemCount: hostels.length,
      itemBuilder: (context, index) {
        final hostel = hostels[index];
        return HostelCard(
              rating: hostel['rating'] as String,
              imageUrl: hostel['imageUrl'] as String,
              price1: hostel['price1'] as String,
              price2: hostel['price2'] as String,
              beds: hostel['beds'] as String,
              hostelName: hostel['hostelName'] as String,
              location: hostel['location'] as String,
              hostelImg: 'assets/hostel1st.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ViewScreen(
                          backgroundImage: hostel['imageUrl'] as String,
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
            )
            .animate(delay: Duration(milliseconds: 100 * index))
            .slideX(
              begin: index % 2 == 0 ? -0.3 : 0.3,
              duration: 500.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(
              duration: 400.ms,
              delay: Duration(milliseconds: 50 * index),
            );
      },
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
                  UserLogo()
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 200.ms)
                      .slideX(begin: -0.2, duration: 300.ms),
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                        .animate()
                        .slideX(
                          begin: 0.5,
                          duration: 300.ms,
                          curve: Curves.easeOut,
                        )
                        .fadeIn(delay: 150.ms, duration: 200.ms)
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          duration: 250.ms,
                          curve: Curves.easeOut,
                        ),
                  ),
                  SizedBox(width: 12),

                  GestureDetector(
                    onTap: toggleSearch,
                    child: Icon(Icons.close, color: Colors.black87, size: 24)
                        .animate()
                        .rotate(begin: 0.25, duration: 300.ms)
                        .fadeIn(delay: 200.ms, duration: 200.ms),
                  ),
                ],
              ),
            ),

            // Search content with PageView for swipe functionality
            Expanded(
              child: Column(
                children: [
                  // Filter tags for activities
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height:
                        selectedTabIndex == 0
                            ? MediaQuery.of(context).size.height * 0.065
                            : 0,
                    child:
                        selectedTabIndex == 0
                            ? _buildFilterTags()
                                .animate()
                                .slideY(
                                  begin: -0.3,
                                  duration: 350.ms,
                                  delay: 100.ms,
                                )
                                .fadeIn(delay: 200.ms, duration: 250.ms)
                            : Container(),
                  ),

                  // PageView for search results with swipe
                  Expanded(
                    child: PageView(
                      controller: _searchPageController,
                      onPageChanged: _onSearchPageChanged,
                      physics:
                          AlwaysScrollableScrollPhysics(), // Ensure swipe works
                      children: [
                        // Activities search results
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: _buildActivitiesGrid(),
                        ),
                        // Hostels search results
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: _buildHostelsGrid(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom navigation
            _buildBottomNavigation()
                .animate()
                .slideY(begin: 1, duration: 400.ms, delay: 300.ms)
                .fadeIn(delay: 350.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBarComponent(
      currentIndex: 0,
      onItemSelected: (index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
        }
      },
    );
  }
}
