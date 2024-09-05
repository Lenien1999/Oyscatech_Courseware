import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckNowButton extends StatelessWidget {
  final bool isPressed;
  final String title;
  final VoidCallback tap;
  CheckNowButton(
      {super.key,
      required this.isPressed,
      required this.tap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        height: isPressed ? 40 : 30,
        width: isPressed ? 160 : 150,
        decoration: BoxDecoration(
          color: isPressed ? Colors.teal : Colors.red,
          borderRadius: BorderRadius.circular(isPressed ? 20 : 10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isPressed ? 20 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
