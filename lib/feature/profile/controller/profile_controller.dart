import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  var isLoading = false.obs;
}