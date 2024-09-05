import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class CourseDetails extends StatelessWidget {
  final String courseCode;
  final String courseTitle;
  final String courseUnit;

  const CourseDetails({
    Key? key,
    required this.courseCode,
    required this.courseTitle,
    required this.courseUnit,
  }) : super(key: key);

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
            _buildResourceSection('Download Lecture Notes'),
            const Divider(),
            _buildResourceSection('Download Assignment'),
            const Divider(),
            _buildResourceSection('Download Past Questions'),
          ],
        ),
      ),
    );
  }

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

  Widget _buildResourceSection(String title) {
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
            onPressed: () {
              // Implement your download logic here
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              'Download',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
            ),
          ),
        ],
      ),
    );
  }
}
