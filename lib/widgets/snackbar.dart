import 'package:flutter/material.dart';
import 'package:get/get.dart';

void mySnackbar( String title,  String message, Color color) {
  Get.snackbar(
    title, message,
    margin: const EdgeInsets.all(10),
    animationDuration: const Duration(milliseconds: 500),
    colorText: Colors.white,
    backgroundColor: color, 
    snackPosition: SnackPosition.BOTTOM,
  );
}