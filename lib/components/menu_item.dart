import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/controller.dart';
import 'package:ucris_oyscatech/constant/responsive.dart';
 

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.screenSize,
    required this.scaffoldKey,
    required this.pages,
  });
  final List<Widget> pages;

  final Size screenSize;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    children: [munuIcon(), TopNav(context)],
                  )
                : Row(
                    children: [
                      munuIcon(),
                      Expanded(
                        child: TopNav(context),
                      ),
                    ],
                  ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [...pages],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row TopNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildMenuItem(
            title: 'Home',
            onpress: () {
              controller.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'Review',
            onpress: () {
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'Contact Us',
            onpress: () {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
      ],
    );
  }

  Container munuIcon() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.teal,
          Colors.transparent,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )));
  }

  Widget buildMenuItem(
      {required String title,
      required VoidCallback onpress,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero, // Set the padding to zero
          )),
          onPressed: onpress,
          child: Text(
            title,
            style: TextStyle(
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 14,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
    );
  }
}
