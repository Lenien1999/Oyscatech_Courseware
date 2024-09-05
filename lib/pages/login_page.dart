import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucris_oyscatech/constant/responsive.dart';
import 'package:ucris_oyscatech/db/auth_controller/authcontroller.dart';
import 'package:ucris_oyscatech/pages/homepage.dart';
import 'package:ucris_oyscatech/widget/button.dart';

import '../widget/textformfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final bool _isPressed = false;

  final _key = GlobalKey<FormState>();

  final authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Center(
          child: SizedBox(
            width: ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context)
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _key,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFielWidget(
                      controller: emailController,
                      icon: Icons.email,
                      title: "email"),
                  const SizedBox(height: 20),
                  TextFielWidget(
                    controller: passwordController,
                    icon: Icons.lock,
                    title: "password",
                  ),
                  const SizedBox(height: 20),
                  CheckNowButton(
                    isPressed: _isPressed,
                    tap: () async {
                      if (_key.currentState!.validate()) {
                        await authcontroller.signInUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    title: 'Login',
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const HomePage());
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Return",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: ' Home',
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
