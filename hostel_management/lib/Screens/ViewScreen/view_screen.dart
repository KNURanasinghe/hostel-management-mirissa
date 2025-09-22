import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Screens/create_rating.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_image.dart';
import 'package:hostel_management/Widgets/AppBar/app_bar_user_set.dart';
import 'package:hostel_management/Widgets/PageRoute/custom_page_route.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/filter_tags.dart';
import 'package:hostel_management/Widgets/verticle_action_button.dart';

class ViewScreen extends StatefulWidget {
  final List<dynamic> hostelList;
  // Changed to accept list of hostels
  final int initialIndex; // Starting hostel index

  const ViewScreen({
    super.key,
    required this.hostelList,
    this.initialIndex = 0,
  });

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  final Map<int, VideoPlayerController?> _videoControllers = {};
  final Map<int, bool> _videoInitialized = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    // Initialize video for current hostel
    _initializeVideoForIndex(_currentIndex);

    // Preload next video if available
    if (_currentIndex + 1 < widget.hostelList.length) {
      _initializeVideoForIndex(_currentIndex + 1);
    }
  }

  void _initializeVideoForIndex(int index) {
    if (index >= widget.hostelList.length) return;

    final hostelData = widget.hostelList[index];
    final videos = hostelData['videos'] ?? [];

    if (videos.isNotEmpty) {
      final videoUrl = videos[0]['url'];
      final controller = VideoPlayerController.network(videoUrl);

      _videoControllers[index] = controller;
      _videoInitialized[index] = false;

      controller
          .initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _videoInitialized[index] = true;
              });

              // Auto-play if this is the current video
              if (index == _currentIndex) {
                controller.setLooping(true);
                controller.play();
              }
            }
          })
          .catchError((error) {
            print('Error initializing video for index $index: $error');
            if (mounted) {
              setState(() {
                _videoInitialized[index] = false;
              });
            }
          });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Pause previous video
    _videoControllers.forEach((key, controller) {
      if (key != index && controller != null) {
        controller.pause();
      }
    });

    // Play current video
    final currentController = _videoControllers[index];
    if (currentController != null && _videoInitialized[index] == true) {
      currentController.setLooping(true);
      currentController.play();
    }

    // Preload next videos
    if (index + 1 < widget.hostelList.length &&
        !_videoControllers.containsKey(index + 1)) {
      _initializeVideoForIndex(index + 1);
    }
    if (index + 2 < widget.hostelList.length &&
        !_videoControllers.containsKey(index + 2)) {
      _initializeVideoForIndex(index + 2);
    }

    // Dispose old videos (keep only current and next 2)
    List<int> keysToRemove = [];
    _videoControllers.forEach((key, controller) {
      if (key < index - 1 || key > index + 2) {
        controller?.dispose();
        keysToRemove.add(key);
      }
    });

    for (int key in keysToRemove) {
      _videoControllers.remove(key);
      _videoInitialized.remove(key);
    }
  }

  @override
  void dispose() {
    _videoControllers.forEach((_, controller) {
      controller?.dispose();
    });
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: widget.hostelList.length,
        itemBuilder: (context, index) {
          return _buildHostelPage(widget.hostelList[index], index);
        },
      ),
    );
  }

  Widget _buildHostelPage(Map<String, dynamic> hostelData, int index) {
    return HostelPageView(
      hostelData: Map<String, dynamic>.from(hostelData),
      videoController: _videoControllers[index],
      isVideoInitialized: _videoInitialized[index] ?? false,
      isCurrentPage: index == _currentIndex,
    );
  }
}

class HostelPageView extends StatefulWidget {
  final Map<String, dynamic> hostelData;
  final VideoPlayerController? videoController;
  final bool isVideoInitialized;
  final bool isCurrentPage;

  const HostelPageView({
    super.key,
    required this.hostelData,
    this.videoController,
    required this.isVideoInitialized,
    required this.isCurrentPage,
  });

  @override
  State<HostelPageView> createState() => _HostelPageViewState();
}

class _HostelPageViewState extends State<HostelPageView> {
  bool showFullDescription = false;
  final int _currentMediaIndex = 0;
  bool _showingVideo = false;

  bool _isVideoPaused = false;

  @override
  void initState() {
    super.initState();
    final videos = widget.hostelData['videos'] ?? [];
    _showingVideo = videos.isNotEmpty;
  }

  @override
  void didUpdateWidget(HostelPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset pause state when switching to a new page
    if (widget.isCurrentPage && !oldWidget.isCurrentPage) {
      _isVideoPaused = false;
    }
  }

  String _formatRating() {
    final rating = widget.hostelData['rating'];
    if (rating == null) return '0.0';
    final overall = rating['overall'] ?? 0;
    return overall > 0 ? overall.toStringAsFixed(1) : '0.0';
  }

  String _getLocationString() {
    final location = widget.hostelData['location'];
    if (location == null) return 'Unknown Location';

    final city = location['city'] ?? '';
    final country = location['country'] ?? '';

    if (city.isNotEmpty && country.isNotEmpty) {
      return '$city, $country';
    } else if (city.isNotEmpty) {
      return city;
    } else if (country.isNotEmpty) {
      return country;
    }

    return 'Unknown Location';
  }

  List<String> _getAmenities() {
    final amenities = widget.hostelData['amenities'];
    if (amenities == null) return [];

    List<String> allAmenities = [];
    if (amenities['basic'] != null) {
      allAmenities.addAll(List<String>.from(amenities['basic']));
    }
    if (amenities['kitchen'] != null) {
      allAmenities.addAll(List<String>.from(amenities['kitchen']));
    }
    if (amenities['common'] != null) {
      allAmenities.addAll(List<String>.from(amenities['common']));
    }
    if (amenities['services'] != null) {
      allAmenities.addAll(List<String>.from(amenities['services']));
    }

    return allAmenities;
  }

  Widget _buildRoomTypes() {
    final rooms = widget.hostelData['rooms'] ?? [];
    if (rooms.isEmpty) return Container();

    return Column(
      children: [
        Row(
          children:
              rooms.map<Widget>((room) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InterTextWidget(
                    text: room['type']?.toString().capitalize() ?? 'Room',
                    fontSize: 12,
                    color: Color(0xFFD1D1D1),
                    fontWeight: FontWeightConst.semiBold,
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 4),
        Row(
          children:
              rooms.map<Widget>((room) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    '\$${room['price'] ?? 0}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  String _getCurrentImageUrl() {
    final images = List<String>.from(widget.hostelData['images'] ?? []);
    if (images.isEmpty) return '';

    // If showing video, use first image as fallback
    if (_showingVideo) return images.isNotEmpty ? images[0] : '';

    // Otherwise cycle through images
    return images[_currentMediaIndex % images.length];
  }

  @override
  Widget build(BuildContext context) {
    final hostelName = widget.hostelData['name'] ?? 'Unknown Hostel';
    final description =
        widget.hostelData['description'] ?? 'No description available';
    final reviewCount = widget.hostelData['reviewCount'] ?? 0;
    final totalBeds = widget.hostelData['totalBeds'] ?? 0;
    final images = List<String>.from(widget.hostelData['images'] ?? []);

    return Stack(
      children: [
        // Background Media (Video or Image)
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:
              _showingVideo &&
                      widget.isVideoInitialized &&
                      widget.videoController != null
                  ? GestureDetector(
                    onTap: () {
                      if (widget.videoController != null) {
                        setState(() {
                          if (_isVideoPaused) {
                            widget.videoController!.play();
                            _isVideoPaused = false;
                          } else {
                            widget.videoController!.pause();
                            _isVideoPaused = true;
                          }
                        });
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(widget.videoController!),
                        // Optional: Show play/pause icon overlay
                        if (_isVideoPaused)
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white.withOpacity(0.8),
                            size: 80,
                          ),
                      ],
                    ),
                  )
                  : _getCurrentImageUrl().isNotEmpty
                  ? Image.network(
                    _getCurrentImageUrl(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return images.isNotEmpty
                          ? Image.network(images[0], fit: BoxFit.cover)
                          : Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported, size: 50),
                          );
                    },
                  )
                  : Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported, size: 50),
                        SizedBox(height: 10),
                        Text('No media available'),
                      ],
                    ),
                  ),
        ),

        // Scroll Indicator
        // Positioned(
        //   right: 20,
        //   top: MediaQuery.of(context).size.height * 0.45,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.5),
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //     child: Column(
        //       children: [
        //         Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 20),
        //         Text(
        //           'Scroll',
        //           style: TextStyle(color: Colors.white, fontSize: 10),
        //         ),
        //         Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
        //       ],
        //     ),
        //   ),
        // ),

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
                  // Hostel Name with Image
                  Row(
                    children: [
                      ClipOval(
                        child:
                            images.isNotEmpty
                                ? Image.network(
                                  images[0],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.grey,
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                )
                                : Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey,
                                  child: Icon(Icons.home, color: Colors.white),
                                ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          hostelName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Description with Read More
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InterTextWidget(
                          text:
                              showFullDescription
                                  ? description
                                  : description.length > 50
                                  ? '${description.substring(0, 50)}...'
                                  : description,
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeightConst.semiBold,
                        ),
                      ),
                      if (description.length > 50)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showFullDescription = !showFullDescription;
                            });
                          },
                          child: Text(
                            showFullDescription ? 'Read less' : 'Read More',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Location, Rating, and Availability Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      // Location
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/view_location.png',
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              _getLocationString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Rating
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/yellow_start.png',
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${_formatRating()} ($reviewCount)',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Availability
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/yellow_cutlery.png',
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '$totalBeds beds',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Amenities (if any)
                  if (_getAmenities().isNotEmpty) ...[
                    Text(
                      'Amenities:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children:
                          _getAmenities().take(6).map((amenity) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                amenity,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Price Range and Choose Room Button
                  Row(
                    children: [
                      // Room Types and Prices
                      Expanded(child: _buildRoomTypes()),

                      // Choose Room Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            SlidePageRoute(page: CreateRating()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 40,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, 0.50),
                              end: Alignment(1.00, 0.50),
                              colors: [
                                const Color(0xFF00B1D6),
                                const Color(0xFF00358D),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: InterTextWidget(
                              text: 'Choose Room',
                              fontSize: 16,
                              color: Color(0xFFFEFEFE),
                              fontWeight: FontWeightConst.semiBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
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

        // Filter Tags
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
    );
  }
}

// Extension to capitalize strings
extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
