import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/controller.dart';
import 'package:ucris_oyscatech/constant/style.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.10),
            menuItem(
                title: 'Home',
                tap: () {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
            divider(),
            menuItem(
                title: 'Courses',
                tap: () {
                  controller.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
            divider(),
            menuItem(
                title: 'Resources',
                tap: () {
                  controller.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
            divider(),
            menuItem(
                title: 'Annoucements',
                tap: () {
                  controller.animateToPage(3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
            divider(),
            menuItem(
                title: 'About UCRIS',
                tap: () {
                  controller.animateToPage(4,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
            divider(),
            menuItem(
                title: 'Login',
                tap: () {
                  controller.animateToPage(5,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }

  Divider divider() {
    return const Divider(
      height: 0.5,
      color: Colors.white,
    );
  }

  Widget menuItem({required String title, required VoidCallback tap}) {
    return GestureDetector(
      onTap: tap,
      child: AnimatedContainer(
        curve: Curves.easeInCubic,
        duration: const Duration(seconds: 2),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 155, 33, 177),
          // Added border radius
        ),
        child: ListTile(
          tileColor: Colors.white,
          title: Text(
            title,
            style: textStyle(
              color: Colors.white,
              fontsize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
