import 'package:flutter/material.dart';
import 'package:hostel_management/Widgets/TopDownSheet/rating_sheet.dart';
import 'package:hostel_management/Widgets/TopDownSheet/save_sheet.dart'; // Add this import
import 'package:hostel_management/Widgets/TopDownSheet/share_sheet.dart';

class VerticleActionButton extends StatelessWidget {
  const VerticleActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          onTap:
              () => ShareSheet().showShareSheet(context), // Share functionality
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
        GestureDetector(
          onTap: () => SaveSheet().showSaveSheet(context), // 👈 Add this line
          child: ClipOval(
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
        ),
      ],
    );
  }
}

// Rest of your existing code remains the same...

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
// Updated share sheet implementation

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
