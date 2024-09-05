import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/widget/body_text.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        ImageSection(screenSize: screenSize, image: "assets/images/oysc.jpg"),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const TitleText(title: 'About UCRIS-OYSCATECH'),
              const BodyText(
                  text:
                      'The Unified Course Resource Information System (UCRIS) is an innovative digital platform designed to enhance the academic experience for students and faculty at OYSCATECH. UCRIS centralizes all course-related materials, providing a streamlined and efficient system for accessing, managing, and distributing educational resources.',
                  color: Color.fromARGB(255, 119, 115, 115)),
              const TitleText(title: 'Key Features'),
              _buildBulletPoint(
                  "Centralized Repository:",
                  "UCRIS consolidates lecture notes, assignments, study guides, "
                      "and past exam papers into one accessible location, ensuring that students have everything they need at their fingertips."),
              _buildBulletPoint("User-Friendly Interface:",
                  "The platform is designed with a focus on simplicity and usability, allowing students and faculty to navigate and find resources effortlessly."),
              _buildBulletPoint("Accessibility:",
                  "UCRIS is accessible from any device with internet access, making it convenient for students to study and review materials anytime, anywhere."),
              _buildBulletPoint("Up-to-Date Resources:",
                  "Faculty can easily upload and update course materials, ensuring that students always have access to the latest information."),
              _buildBulletPoint("Interactive Features:",
                  "UCRIS supports interactive elements such as multimedia resources and customizable learning paths, catering to diverse learning styles."),
              const TitleText(title: 'Why UCRIS?'),
              const BodyText(
                  text:
                      "Traditional methods of distributing course materials often involve multiple platforms and inconsistent access, leading to confusion and missed opportunities for students. UCRIS addresses these challenges by providing a unified, reliable, and user-centric solution that aligns with the modern needs of education..",
                  color: Color.fromARGB(255, 126, 122, 122)),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        FooterWidget(screenSize: screenSize)
      ],
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(
              child: RichText(
                  text: TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                TextSpan(
                  text: ' $description',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                )
              ])))
        ]));
  }
}
