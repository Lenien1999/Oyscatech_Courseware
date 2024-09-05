// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:ucris_oyscatech/components/courses.dart';
import 'package:ucris_oyscatech/constant/style.dart';

import 'package:ucris_oyscatech/widget/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<String> categories = [
    'Lecture Notes',
    'Assignments',
    'Lecture Videos',
    'Past Question',
    'Journals',
    'Project/Thesis',
    'Announcement'
  ];

  Uint8List? uploadFile;
  String? fileName;

  String selectedCategory = 'Lecture Notes';
  final _formKey = GlobalKey<FormState>();
  String selectedLevel = 'ND I';
  String selectedCourse = '';
  String description = '';
  String title = "";
  String authors = "";
  String year = '';
  final TextEditingController _fileController = TextEditingController();

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          uploadFile = result.files.single.bytes;
          fileName = result.files.single.name;
          _fileController.text = fileName!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File selection canceled')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // Handle logout if necessary
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        backgroundColor: appColor,
        centerTitle: true,
        title: const Text(
          'Admin - UCRIS',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
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
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    children: categories.map((category) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: selectedCategory == category
                                ? Colors.teal
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.blueGrey[900],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _displayCategoryDetails(),
          const SizedBox(height: 30),
          _displayFilesBasedOnCategory(selectedCategory),
        ],
      ),
    );
  }

  Widget _displayCategoryDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            selectedCategory != 'Project/Thesis' &&
                    selectedCategory != 'Journals'
                ? DropdownButtonFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Select Level'),
                    value: selectedLevel,
                    items: courses.keys.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value as String;
                        selectedCourse = '';
                      });
                    },
                  )
                : TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: '$selectedCategory Title '),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Please enter $selectedCategory Title '
                        : null,
                  ),
            const SizedBox(height: 16),
            selectedCategory != 'Project/Thesis' &&
                    selectedCategory != 'Journals'
                ? DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Select Course'),
                    value: selectedCourse.isEmpty ? null : selectedCourse,
                    items: courses[selectedLevel]!.map((course) {
                      return DropdownMenuItem(
                        value: course['code'],
                        child: Text(
                          '${course['code']} - ${course['title']} (${course['unit']} Units)',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCourse = value as String;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a course' : null,
                  )
                : TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: '$selectedCategory Author '),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Author Name' : null,
                  ),
            const SizedBox(height: 16),
            selectedCategory == 'Project/Thesis' ||
                    selectedCategory == 'Journals'
                ? TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: '$selectedCategory Year '),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter valid year' : null,
                  )
                : Container(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fileController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Selected File',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: pickFile,
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please pick a file' : null,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                ),
                child: Text(
                  'Add $selectedCategory',
                  style: textStyle(
                      color: Colors.white,
                      fontsize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && uploadFile != null) {
      try {
        // Upload file to Firebase Storage
        _showCheckBalanceDialog();
        final storageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');
        final uploadTask = await storageRef.putData(uploadFile!);
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        // Save file data to Firestore
        await FirebaseFirestore.instance.collection('course_materials').add({
          'level': selectedLevel,
          'course': selectedCourse,
          'type': selectedCategory,
          'description': description,
          'fileName': fileName,
          'downloadUrl': downloadUrl,
          'timestamp': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$selectedCategory added successfully')),
        );

        Get.to(() => const AdminPage());
        setState(() {
          selectedCourse = '';
          description = '';
          uploadFile = null;
          _fileController.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload: $e')),
        );
      } finally {
        // Close the loading dialog
        Navigator.of(context).pop();
      }
    }
  }

  Widget _displayFilesBasedOnCategory(String category) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('course_materials')
          .where('type', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No files uploaded yet.'));
        }

        final files = snapshot.data!.docs;

        return Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 230, 225, 225)
                          .withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 9),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: const Color.fromARGB(255, 199, 196, 196)),
                ),
                child: Column(
                  children: [
                    const TitleText(title: "History"),
                    const SizedBox(
                      height: 20,
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('S/N')),
                        DataColumn(label: Text('Course Code')),
                        DataColumn(label: Text('Course Title')),
                        DataColumn(label: Text('Level')),
                        DataColumn(label: Text('Download File')),
                        DataColumn(label: Text('Action')), // New Action Column
                      ],
                      rows: files.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        var file = entry.value;
                        String courseCode = file['course'] ?? 'N/A';
                        String level = file['level'] ?? 'N/A';

                        // Fetch the course title using the course code and level
                        String courseTitle = getCourseTitle(level, courseCode);

                        return DataRow(cells: [
                          DataCell(Text('$index')), // Serial Number
                          DataCell(Text(courseCode)),
                          DataCell(Text(courseTitle)),
                          DataCell(Text(level)),
                          DataCell(IconButton(
                            icon: const Icon(
                              Icons.download,
                              color: appColor,
                            ),
                            onPressed: () async {
                              final url = file['downloadUrl'];
                              if (url != null && await canLaunch(url)) {
                                await launch(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Could not open the file')),
                                );
                              }
                            },
                          )),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _editFile(
                                      file.id, file); // Trigger edit action
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _deleteFile(file.id, file);
                                },
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  getCourseTitle(String level, String courseCode) {
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

  void _editFile(String id, QueryDocumentSnapshot file) {
    showDialog(
      context: context,
      builder: (context) {
        Uint8List? updatedFile;
        String updatedFileName = file['fileName'] ?? '';

        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Edit File'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: updatedFileName,
                  decoration: const InputDecoration(
                    labelText: 'Current File',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: appColor),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null && result.files.single.bytes != null) {
                      setState(() {
                        updatedFile = result.files.single.bytes;
                        updatedFileName = result.files.single.name;
                      });
                    }
                  },
                  child: Text(
                    "Pick New File",
                    style: textStyle(
                        color: Colors.white,
                        fontsize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                if (updatedFileName.isNotEmpty)
                  Text('Selected: $updatedFileName'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the edit dialog
                },
                child: Text(
                  "Cancel",
                  style: textStyle(
                    color: Colors.red,
                    fontsize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: appColor),
                onPressed: () async {
                  if (updatedFile != null) {
                    // Show loading indicator before starting the upload
                    _showCheckBalanceDialog();

                    try {
                      // Upload the file
                      String downloadUrl =
                          await _uploadFile(updatedFile!, updatedFileName);

                      // Update Firestore with the new file information
                      await FirebaseFirestore.instance
                          .collection("course_materials")
                          .doc(id)
                          .update({
                        "downloadUrl": downloadUrl,
                        "fileName": updatedFileName,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('File updated successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update file: $e')),
                      );
                    } finally {
                      // Close the loading indicator and edit dialog after upload completes
                      Navigator.of(context).pop(); // Close the edit dialog
                    }
                  }
                },
                child: Text(
                  "Update File",
                  style: textStyle(
                    color: Colors.white,
                    fontsize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  // Function to upload file to Firebase Storage
  Future<String> _uploadFile(Uint8List fileBytes, String fileName) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('course_files/$fileName');
    UploadTask uploadTask = storageRef.putData(fileBytes);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  void _deleteFile(String id, QueryDocumentSnapshot file) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete ${file['fileName']}"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showCheckBalanceDialog();
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: appColor),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("course_materials")
                        .doc(id)
                        .delete();
                    _showCheckBalanceDialog();
                    Get.back();
                  },
                  child: Text(
                    "Delete",
                    style: textStyle(
                        color: Colors.white,
                        fontsize: 13,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  void _showCheckBalanceDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor:
              Colors.transparent, // Transparent background for custom styling
          child: SingleChildScrollView(
            // Wrap content to handle overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25),
                LoadingIndicator(
                  indicatorType: Indicator.ballRotate,
                  colors: [Colors.green, Colors.white, Colors.yellow],
                  strokeWidth: 1.5,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent,
                ),
                SizedBox(height: 15),
                Text(
                  "Processing...",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a delay for processing
  }
}
