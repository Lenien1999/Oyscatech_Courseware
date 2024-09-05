import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';

class ImageSection extends StatelessWidget {
  final Size screenSize;
  final String image;

  const ImageSection({
    required this.screenSize,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height * 0.6,
      width: screenSize.width,
      child: Stack(
        children: [
          // Image background
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height * 0.5,
          ),
          // Gradient overlay with text
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColor, Colors.black.withOpacity(0.0)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Welcome to the Unified Course Resource Information System (UCRIS), your central hub for all course materials and resources within the Computer Science Department at OYSCATECH.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0), // Space between text and button
                // Button
                ElevatedButton(
                  onPressed: () {
                    // Add your check update action here
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Check Update',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
