import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/controller.dart';
import 'package:ucris_oyscatech/components/faqtile.dart';
import 'package:ucris_oyscatech/constant/responsive.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/widget/body_text.dart';
import 'package:ucris_oyscatech/widget/button.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class UcrisHomepage extends StatelessWidget {
  const UcrisHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final isLargeOrMedium = ResponsiveWidget.isLargeScreen(context) ||
        ResponsiveWidget.isMediumScreen(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageSection(
            screenSize: screenSize,
            image: 'assets/images/oysc.jpg',
          ),
          const SizedBox(height: 40),
          const TitleText(title: "e-Courseware"),
          const BodyText(
              text:
                  'The e-Courseware is a repository of available digital course material of the OYO STATE COLLEGE OF AGRICULTURE AND TECHNOLOGY, COMPUTER SCIENCE DEPARTMENT that will help you in your course of studies.You can filter for the course material you want by Faculty, Semester and Level.',
              color: Colors.black),
          const BodyText(
              text:
                  'To be able to read any of the course materials in this library offline, you must have Adobe acrobat reader (or any other pdf reader) installed on your computer.',
              color: Color.fromARGB(255, 110, 108, 108)),
          const SizedBox(height: 20),
          ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _stepsWidget(
                        "To read any of the course materials online, click on the title/link to open that material in your browser.",
                        '1',
                        Colors.teal,
                        screenSize,
                        context),
                    SizedBox(
                      width: screenSize.width * 0.04,
                    ),
                    _stepsWidget(
                        "To download, either use the download/save option that appears after you have opened it in your browser or right-click the title/link and select the “save link as..” option.",
                        '2',
                        Colors.redAccent,
                        screenSize,
                        context),
                    SizedBox(
                      width: screenSize.width * 0.04,
                    ),
                  ],
                )
              : Column(
                  children: [
                    _stepsWidget(
                        "To read any of the course materials online, click on the title/link to open that material in your browser.",
                        '1',
                        Colors.teal,
                        screenSize,
                        context),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    _stepsWidget(
                        "To download, either use the download/save option that appears after you have opened it in your browser or right-click the title/link and select the “save link as..” option.",
                        '2',
                        Colors.redAccent,
                        screenSize,
                        context),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          const TitleText(title: 'Learn at any place at your pace'),
          _levelCourseWidget(context),
          ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context)
              ? Row(
                  children: [
                    Expanded(child: _faqImage()),
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    Expanded(
                      child: _faqDetails(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _faqImage(),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    _faqDetails(),
                  ],
                ),
          const TitleText(title: 'Featured Resources'),
          isLargeOrMedium
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _featureCourse(
                        image: 'assets/images/com.jpg',
                        title:
                            'Structure and Interpretation of Computer Programs',
                        description:
                            "Structure and Interpretation of Computer Programs is a computer science textbook by Massachusetts Institute of Technology professors Harold Abelson and Gerald Jay...",
                        context: context),
                    _featureCourse(
                        image: 'assets/images/clean.jpg',
                        title: 'Clean Code',
                        description:
                            "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees...",
                        context: context),
                    _featureCourse(
                        image: 'assets/images/march.jpg',
                        title:
                            'Why Machines Learn: The Elegant Maths Behind Modern AI',
                        description:
                            "An invaluable companion for anyone who wants a deep understanding of what’s under the hood of often inscrutable machines...",
                        context: context),
                    _featureCourse(
                        image: 'assets/images/algo.jpg',
                        title: 'Introduction to Algorithms',
                        description:
                            "ntroduction to Algorithms is a book on computer programming by Thomas H. Cormen, Charles E. Leiserson...",
                        context: context),
                  ],
                )
              : Column(children: [
                  _featureCourse(
                      image: 'assets/images/clean.jpg',
                      title:
                          'Structure and Interpretation of Computer Programs',
                      description:
                          "Structure and Interpretation of Computer Programs is a computer science textbook by Massachusetts Institute of Technology professors Harold Abelson and Gerald Jay..",
                      context: context),
                  const SizedBox(
                    height: 14,
                  ),
                  _featureCourse(
                      image: 'assets/images/clean.jpg',
                      title: 'Clean Code',
                      description:
                          "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees...",
                      context: context),
                  const SizedBox(
                    height: 14,
                  ),
                  _featureCourse(
                      image: 'assets/images/clean.jpg',
                      title: 'Clean Code',
                      description:
                          "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees...",
                      context: context),
                  const SizedBox(
                    height: 14,
                  ),
                  _featureCourse(
                      image: 'assets/images/clean.jpg',
                      title: 'Clean Code',
                      description:
                          "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees...",
                      context: context),
                ]),
          const SizedBox(
            height: 15,
          ),
          FooterWidget(screenSize: screenSize)
        ],
      ),
    );
  }

  _levelCourseWidget(context) {
    final isLargeOrMedium = ResponsiveWidget.isLargeScreen(context) ||
        ResponsiveWidget.isMediumScreen(context);

    return Container(
      child: isLargeOrMedium
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _levelCourseParameers(
                    level: 'ND 1',
                    press: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }),
                const SizedBox(
                  width: 30,
                ),
                _levelCourseParameers(
                    level: 'ND 2',
                    press: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }),
                const SizedBox(
                  width: 10,
                ),
                _levelCourseParameers(
                    level: 'HND 1',
                    press: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }),
                const SizedBox(
                  width: 10,
                ),
                _levelCourseParameers(
                    level: 'HND 2',
                    press: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }),
              ],
            )
          : Column(
              children: [
                _levelCourseParameers(level: 'ND 1', press: () {}),
                const SizedBox(
                  height: 10,
                ),
                _levelCourseParameers(level: 'ND 2', press: () {}),
                const SizedBox(
                  height: 10,
                ),
                _levelCourseParameers(level: 'HND 1', press: () {}),
                const SizedBox(
                  height: 10,
                ),
                _levelCourseParameers(level: 'HND 2', press: () {}),
              ],
            ),
    );
  }

  _levelCourseParameers({required String level, required VoidCallback press}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Column(
        children: [
          const Icon(
            Icons.read_more_rounded,
            color: appColor,
            size: 100,
          ),
          Text(level,
              textAlign: TextAlign.center,
              style: textStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontsize: 20)),
          CheckNowButton(
            isPressed: true,
            tap: press,
            title: 'Click',
          )
        ],
      ),
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

  _faqImage() => Image.asset("assets/images/annouce.png", fit: BoxFit.contain);
  _stepsWidget(String title, String icon, Color color, Size screenSize,
      BuildContext context) {
    return SizedBox(
      width: ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context)
          ? screenSize.width * 0.2
          : screenSize.width * 0.8,
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: color,
                  child: Text(
                    icon,
                    style: textStyle(
                        color: Colors.white,
                        fontsize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: textStyle(
                      color: color, fontsize: 14, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _featureCourse(
      {required String image,
      required String title,
      required String description,
      required BuildContext context}) {
    final isLargeOrMedium = ResponsiveWidget.isLargeScreen(context) ||
        ResponsiveWidget.isMediumScreen(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 221, 218, 218).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ]),
      width: isLargeOrMedium
          ? MediaQuery.of(context).size.width * 0.15
          : MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.1,
            fit: BoxFit.cover,
          ),
          Text(
            "Resources",
            style: textStyle(
                color: appColor, fontsize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: textStyle(
                color: const Color.fromARGB(144, 11, 100, 63),
                fontsize: 18,
                fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            overflow: TextOverflow.visible,
            style: textStyle(
                color: Colors.grey,
                fontsize: 14,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
