import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/widget/image_section.dart';

class AnnoucementPage extends StatelessWidget {
  const AnnoucementPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        ImageSection(screenSize: screenSize, image: "assets/images/oysc.jpg"),
      ],
    );
  }
}
