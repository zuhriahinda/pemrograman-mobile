import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/home/views/intro_page.dart';
import 'package:flutter_application_1/app/modules/home/views/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(HomeView()); //Navigate ke home Page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      Get.off(HomeView()); //Navigate ke Login Page
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    // Show logout confirmation dialog with custom button colors
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: const Color.fromARGB(255, 0, 0, 0),
      cancelTextColor: const Color.fromARGB(255, 255, 255, 255),
      buttonColor: const Color.fromARGB(
          255, 255, 127, 7), // Custom color for the 'Yes' button
      onCancel: () {},
      onConfirm: () async {
        // User clicked 'Yes,' perform logout
        await _auth.signOut();
        Get.offAll(
            IntroPage()); // Menghapus semua halaman dari tumpukan dan navigasi ke halaman login
      },
    );
  }
}
