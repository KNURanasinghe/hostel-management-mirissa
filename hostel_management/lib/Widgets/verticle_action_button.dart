import 'package:flutter/material.dart';
import 'package:hostel_management/Widgets/TopDownSheet/rating_sheet.dart';

class VerticleActionButton extends StatelessWidget {
  const VerticleActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _showTopDraggableSheet(context);
          },
          child: ClipOval(
            child: Container(
              width: 43,
              height: 43,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: Image.asset(
                  'assets/locations.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 17),
        GestureDetector(
          onTap: () {
            RatingSheetTop.show(context);
          },
          child: ClipOval(
            child: Container(
              width: 43,
              height: 43,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: Image.asset(
                  'assets/edit.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 17),
        GestureDetector(
          onTap: () => _showShareSheet(context), // 👈 open bottom sheet
          child: ClipOval(
            child: Container(
              width: 43,
              height: 43,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: Image.asset(
                  'assets/share.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 17),
        ClipOval(
          child: Container(
            width: 43,
            height: 43,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                'assets/save_reals.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void _showTopDraggableSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.topCenter,
        child: _TopDraggableSheet(
          minChildSize: 0.6,
          maxChildSize: 0.95,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: ListView(
              // 👈 replace Column with ListView
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Hostel Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // // 🗺️ Map View
                // SizedBox(
                //   height: 200,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(12),
                //     child: const GoogleMap(
                //       initialCameraPosition: CameraPosition(
                //         target: LatLng(5.9485, 80.4591),
                //         zoom: 14,
                //       ),
                //       zoomControlsEnabled: false,
                //       myLocationButtonEnabled: false,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),

                // Hostel Info Card
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1), // start above
          end: Offset.zero, // slide down
        ).animate(anim1),
        child: child,
      );
    },
  );
}

// Simple share sheet implementation
void _showShareSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.4), // dim background
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Stack(
        children: [
          // ✅ Hostel card on top
          // ✅ ActivityCard on top
          // ✅ Hostel card on top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/activity_card.jpeg",
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Hostel First",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text("\$10  •  \$30  •  Dorm / Private Available"),
                    ],
                  ),
                ),
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

Widget _buildContact(String asset, String name) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Column(
      children: [
        CircleAvatar(radius: 25, backgroundImage: AssetImage(asset)),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildShareIcon(IconData icon, String label) {
  return Column(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: Colors.black),
      ),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

/// Custom Top Draggable Sheet
class _TopDraggableSheet extends StatefulWidget {
  final double minChildSize;
  final double maxChildSize;
  final Widget child;

  const _TopDraggableSheet({
    required this.minChildSize,
    required this.maxChildSize,
    required this.child,
  });

  @override
  State<_TopDraggableSheet> createState() => _TopDraggableSheetState();
}

class _TopDraggableSheetState extends State<_TopDraggableSheet> {
  late double currentSize;

  @override
  void initState() {
    super.initState();
    currentSize = widget.minChildSize;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          currentSize -= details.primaryDelta! / screenHeight;
          currentSize = currentSize.clamp(
            widget.minChildSize,
            widget.maxChildSize,
          );
        });
      },
      child: SizedBox(
        height: screenHeight * currentSize,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          child: widget.child, // ✅ now ListView can scroll normally
        ),
      ),
    );
  }
}
