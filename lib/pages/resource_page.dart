// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/courses.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  final List<String> resources = [
    'Journals',
    'Lecture Videos',
    'Project/Thesis',
  ];

  String selectedResource = 'Journals';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        ImageSection(screenSize: screenSize, image: "assets/images/lib.jpg"),
        _buildResourceSelector(),
        const SizedBox(height: 30),
        _selectedResourcesWidget(),
        const SizedBox(height: 30),
        FooterWidget(screenSize: screenSize),
      ],
    );
  }

  Widget _buildResourceSelector() {
    return Container(
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
          const Center(child: TitleText(title: 'Digital Repository')),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: resources.map((resource) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedResource = resource;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: selectedResource == resource
                        ? Colors.teal
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    resource,
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedResource == resource
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
    );
  }

  Widget _selectedResourcesWidget() {
    // Define the columns based on the selected resource type
    List<DataColumn> columns = _getColumnsForSelectedResource();

    // Fetch and display data based on selected resource
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(selectedResource == 'Lecture Videos'
              ? 'course_materials'
              : 'resources')
          .where('type', isEqualTo: selectedResource)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox(width: 30, child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No resources available.'));
        }

        var materials = snapshot.data!.docs;

        List<DataRow> rows = [];
        for (var i = 0; i < materials.length; i++) {
          var material = materials[i];
          rows.add(_buildDataRow(material, i));
        }

        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color.fromARGB(255, 199, 196, 196)),
              ),
              child: DataTable(
                columns: columns,
                rows: rows,
              ),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> _getColumnsForSelectedResource() {
    if (selectedResource == 'Journals' ||
        selectedResource == 'Project/Thesis') {
      return [
        DataColumn(
          label: Text(
            'S/N',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Year',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Author(s)',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Title',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Link(s)',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
      ];
    } else if (selectedResource == 'Lecture Videos') {
      return [
        DataColumn(
          label: Text(
            'S/N',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Courseware',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Title',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
        DataColumn(
          label: Text(
            'Link',
            style: textStyle(
                color: appColor, fontWeight: FontWeight.bold, fontsize: 18),
          ),
        ),
      ];
    }
    return [];
  }

  DataRow _buildDataRow(QueryDocumentSnapshot material, int index) {
    if (selectedResource == 'Lecture Videos') {
      String level = material['level'] ?? 'Unknown';
      String courseCode = material['course'] ?? 'Unknown';
      String courseTitle = getCourseTitle(level, courseCode);

      return DataRow(cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(level)),
        DataCell(Text(courseTitle)),
        DataCell(
          material['downloadUrl'] != null
              ? GestureDetector(
                  onTap: () {
                    _launchURL(material['downloadUrl']);
                  },
                  child: const Text(
                    'Download',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              : const Text('No link available'),
        ),
      ]);
    } else {
      return DataRow(cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(material['year'] ?? 'Unknown')),
        DataCell(Text(material['authors'] ?? 'Unknown')),
        DataCell(Text(material['title'] ?? 'Unknown')),
        DataCell(
          material['downloadUrl'] != null
              ? GestureDetector(
                  onTap: () {
                    _launchURL(material['downloadUrl']);
                  },
                  child: const Text(
                    'Download',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              : const Text('No link available'),
        ),
      ]);
    }
  }

  // Function to launch URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getCourseTitle(String level, String courseCode) {
    List<Map<String, String>>? courseList = courses[level];
    if (courseList != null) {
      for (var course in courseList) {
        if (course['code'] == courseCode) {
          return course['title'] ?? "Unknown Course Title";
        }
      }
    }
    return "Unknown Course";
  }
}
