import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/widget/footer.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';
import 'package:ucris_oyscatech/widget/title_text.dart';

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
    return ListView(children: [
      ImageSection(screenSize: screenSize, image: "assets/images/lib.jpg"),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
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
      ),
      const SizedBox(
        height: 30,
      ),
      _selectedResourcesWidget(),
      const SizedBox(
        height: 30,
      ),
      FooterWidget(screenSize: screenSize),
    ]);
  }

  Widget _selectedResourcesWidget() {
    List<DataColumn> columns = [];
    List<DataRow> rows = [

    ]; // Add your data rows here

    if (selectedResource == 'Journals' ||
        selectedResource == 'Project/Thesis') {
      columns = [
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
      columns = [
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

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromARGB(255, 199, 196, 196)),
          ),
          child: DataTable(
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }
}
