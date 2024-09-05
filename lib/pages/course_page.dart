// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/courses.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/pages/course_details.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

class AcademicLevelSelector extends StatefulWidget {
  const AcademicLevelSelector({super.key});

  @override
  _AcademicLevelSelectorState createState() => _AcademicLevelSelectorState();
}

class _AcademicLevelSelectorState extends State<AcademicLevelSelector> {
  final List<String> AcademicLevel = [
    'ND I',
    'ND II',
    'HND I',
    'HND II',
  ];
  String selectedLevel = 'ND I';
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        ImageSection(screenSize: screenSize, image: "assets/images/bg1.jpg"),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: TitleText(title: 'Select Your Level')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: AcademicLevel.map((level) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLevel = level;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedLevel == level
                            ? Colors.teal
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedLevel == level
                              ? Colors.white
                              : Colors.blueGrey[900],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _displayContentBasedOnLevel(),
        const SizedBox(
          height: 30,
        ),
        FooterWidget(screenSize: screenSize),
      ],
    );
  }

  _displayContentBasedOnLevel() {
    List<Map<String, String>> selectedCourses = courses[selectedLevel]!;
    return Center(
      child: 
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromARGB(255, 199, 196, 196)),
          ),
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text(
                'Course Code',
                style: textStyle(
                    color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
              )),
              DataColumn(
                  label: Text(
                'Course Title',
                style: textStyle(
                    color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
              )),
              DataColumn(
                  label: Text(
                'Course Unit',
                style: textStyle(
                    color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
              )),
              DataColumn(
                  label: Text(
                'Course Details',
                style: textStyle(
                    color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
              )),
            ],
            rows: selectedCourses
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['code']!)),
                      DataCell(Text(item['title']!)),
                      DataCell(Text(item['unit']!)),
                      DataCell(
                        TextButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: appColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetails(
                                  courseCode: item['code']!,
                                  courseTitle: item['title']!,
                                  courseUnit: item['unit']!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
  
    );
  }
}
