// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ValidatorFunction = String? Function(String?);

class TextFielWidget extends StatelessWidget {
  const TextFielWidget({
    super.key,
    required this.controller,
    this.validator,
    required this.icon,
    required this.title,
    this.inputFormatters,
    this.keyboardType,
  });
  final List<TextInputFormatter>? inputFormatters;
  final IconData icon;
  final ValidatorFunction? validator;
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white, // Set the error message color
            fontSize: 14.0, // Set the error message font size
            fontWeight: FontWeight.bold, // Set the error message font weight
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: title,
          hintStyle: TextStyle(color: Colors.grey[600]),
          suffixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
