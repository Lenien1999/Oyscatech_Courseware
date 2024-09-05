import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/widget/body_text.dart';

import '../constant/style.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.4,
      width: screenSize.width,
      decoration: const BoxDecoration(color: appColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/logo1.jpg',
              height: screenSize.height * 0.1,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text:
                      'Ready to dive into your studies? Explore your courses now and make the most of the resources available to you',
                  style: textStyle(
                      color: Colors.white,
                      fontsize: 14,
                      fontWeight: FontWeight.normal),
                  children: [
                    TextSpan(
                      text:
                          ' \nFor any questions or technical support, please contact us at support@oyscatech.edu.ng',
                      style: textStyle(
                          color: Colors.white,
                          fontsize: 14,
                          fontWeight: FontWeight.normal),
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
            const BodyText(
                color: Color.fromARGB(255, 216, 196, 12),
                text: '© 2024 UCRIS_OYSCATECH . All Rights Reserved.')
          ],
        ),
      ),
    );
  }
}
