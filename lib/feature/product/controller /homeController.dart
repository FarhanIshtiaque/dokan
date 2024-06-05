import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var currentIndex = 0.obs;
  final PageController controller = PageController(
    initialPage: 0,
  );
}