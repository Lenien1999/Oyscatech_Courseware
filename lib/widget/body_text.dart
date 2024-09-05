import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color color;
  const BodyText({required this.text, super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        text,
        style: textStyle(
          color: color,
          fontsize: 14,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
