import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle(
        color: appColor,
        fontsize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
