import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(
    {required Color color,
    required double fontsize,
    required FontWeight fontWeight}) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: fontsize,
    fontWeight: fontWeight,
    color: color,
  ));
}
const Color appColor= Color.fromRGBO(3, 73, 44, 1);