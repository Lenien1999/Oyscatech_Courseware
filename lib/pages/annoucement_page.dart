import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/faqtile.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class AnnoucementPage extends StatelessWidget {
  const AnnoucementPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        ImageSection(screenSize: screenSize, image: "assets/images/oysc.jpg"),
        const SizedBox(
          height: 40,
        ),
        _faqDetails(),
        FooterWidget(screenSize: screenSize)
      ],
    );
  }

  _faqDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleText(title: "Latest Annoucement"),
        FaqTile(
          question: "Study Guide for HND 2",
          answer: "New Study Guides Available for HND2 Level Courses ",
        ),
        FaqTile(
          question: "Guest Lecture",
          answer:
              "Guest Lecture on AI and Machine Learning – Join us on 22/09/2024 at Hall",
        ),
        FaqTile(
          question: "MidTerm Exam",
          answer:
              "Midterm Exam Schedule Released – Check the Announcements section for details",
        ),
      ],
    );
  }
}
