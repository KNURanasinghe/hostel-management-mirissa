import 'package:flutter/material.dart';

void _showShareSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.all(16),
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Suggested contacts
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildContact("assets/Profile1.png", "Sarah"),
                      _buildContact("assets/Profile2.png", "Mike"),
                      _buildContact("assets/Profile3.png", "Alex"),
                      _buildContact("assets/Profile4.png", "Emma"),
                      _buildContact("assets/Profile5.png", "David"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Share via section
                const Text(
                  "Share Via",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildShareIcon(Icons.copy, "Copy"),
                    _buildShareIcon(Icons.share, "Share"),
                    _buildShareIcon(Icons.wallet, "WhatsApp"),
                    _buildShareIcon(Icons.facebook, "Facebook"),
                    _buildShareIcon(Icons.camera_alt, "Instagram"),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Helper widgets
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
