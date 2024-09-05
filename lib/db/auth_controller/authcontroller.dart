import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ucris_oyscatech/db/auth_controller/authexception.dart';
import 'package:ucris_oyscatech/pages/admin_page.dart';
import 'package:ucris_oyscatech/pages/homepage.dart';
 

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> fireBaseUser;
  var verificationId = ''.obs;

  Future<void> signInUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.to(() =>
            AdminPage()); // Navigate to AuthScreen after successful sign-in
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      Get.snackbar("Error", e.message ?? "An error occurred",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } catch (_) {
      // Handle any other errors
      const error = SignandLoginFailure('An unknown error has occurred.');
      error.showSnackbar();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => const HomePage()); // Navigate to HomePage after logout
  }
}
