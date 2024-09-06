// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Added for launching the URL
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class CourseDetails extends StatelessWidget {
  final String courseCode;
  final String courseTitle;
  final String courseUnit;

  const CourseDetails({
    super.key,
    required this.courseCode,
    required this.courseTitle,
    required this.courseUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          courseTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Center(child: TitleText(title: 'Course Material')),
            _buildCourseDetails(),
            const SizedBox(height: 30),

            // Lecture Notes Section (from Firebase)
            const TitleText(title: 'Lecture Notes'),
            _buildFirebaseResourceList('Lecture Notes'),
            const Divider(),

            // Assignments Section (from Firebase)
            const TitleText(title: 'Assignments'),
            _buildFirebaseResourceList('Assignments'),
            const Divider(),

            // Past Questions Section (from Firebase)
            const TitleText(title: 'Past Questions'),
            _buildFirebaseResourceList('Past Question'),
          ],
        ),
      ),
    );
  }

  // Function to build the course details section
  Widget _buildCourseDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichText('Course Code: ', courseCode),
        _buildRichText('Course Title: ', courseTitle),
        _buildRichText('Course Unit: ', courseUnit),
        const SizedBox(height: 20),
        const Text(
          'Course Description',
          style: TextStyle(
            color: appColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'This course provides an overview of the field of computer science. '
          'Topics include the history of computing, basic principles of programming, '
          'algorithms, data structures, computer architecture, operating systems, '
          'and networking. The course is designed to introduce students to fundamental '
          'concepts and equip them with the skills necessary for further studies in computer science.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Function to build the rich text for course details
  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Fetch resource files from Firebase and display them dynamically
  Widget _buildFirebaseResourceList(String resourceType) {
    return
     StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('course_materials')
          .where('course', isEqualTo: courseCode)
          .where('type', isEqualTo: resourceType)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox(width: 30, child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No files uploaded for this section.');
        }

        var materials = snapshot.data!.docs;

        return Column(
          children: materials.map((material) {
            String? fileUrl = material['downloadUrl'];
            String fileName = material['fileName'] ?? 'No file uploaded';

            return _buildResourceSection(fileName, fileUrl);
          }).toList(),
        );
      },
    );
  
  
  }

  // Function to build the resource section with a download button
  Widget _buildResourceSection(String title, String? fileUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: fileUrl != null
                ? () {
                    _downloadFile(fileUrl);
                  }
                : null,
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              'Download',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: fileUrl != null ? appColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Function to download the file
  Future<void> _downloadFile(String fileUrl) async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }
}
