// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/components/controller.dart';
import 'package:ucris_oyscatech/components/custom_drawer.dart';

import 'package:ucris_oyscatech/constant/responsive.dart';
import 'package:ucris_oyscatech/constant/style.dart';
import 'package:ucris_oyscatech/pages/about_page.dart';
import 'package:ucris_oyscatech/pages/annoucement_page.dart';
import 'package:ucris_oyscatech/pages/course_page.dart';
import 'package:ucris_oyscatech/pages/login_page.dart';
import 'package:ucris_oyscatech/pages/resource_page.dart';
import 'package:ucris_oyscatech/pages/ucris_homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        endDrawer: ResponsiveWidget.isSmallScreen(context)
            ? const CustomDrawer()
            : null,
        body: SafeArea(
          child: Column(
            children: [
              ResponsiveWidget.isLargeScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context)
                  ? topAppbarMenu(screenSize, context)
                  : Container(),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: const [
                    UcrisHomepage(), AcademicLevelSelector(), ResourcePage(),
                    AnnoucementPage(), AboutPage(), AuthScreen()

                    //
                    //
                    //
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? customAppbar(screenSize)
            : null,
      ),
    );
  }

  Container topAppbarMenu(Size screenSize, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: screenSize.height * 0.1,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Color.fromRGBO(3, 73, 44, 1), width: 8)),
      ),
      // const Color.fromRGBO(3, 73, 44, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo1.jpg',
            height: 50,
          ),
          TopNav(context),
        ],
      ),
    );
  }

  customAppbar(Size screenSize) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(3, 73, 44, 1), // Border color
            width: 4, // Border width
          ),
        )),
        child: AppBar(
          elevation: 0,
          toolbarHeight: screenSize.height * 0.1,
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/images/logo1.jpg',
            height: 50,
          ),
        ),
      ),
    );
  }

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
            title: 'Courses',
            onpress: () {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'Resources',
            onpress: () {
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'Announcements',
            onpress: () {
              controller.animateToPage(3,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'About UCRIS',
            onpress: () {
              controller.animateToPage(4,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
        buildMenuItem(
            title: 'Login',
            onpress: () {
              controller.animateToPage(5,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            context: context),
      ],
    );
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
              color: const Color.fromRGBO(3, 73, 44, 1),
            ),
          )),
    );
  }
}
