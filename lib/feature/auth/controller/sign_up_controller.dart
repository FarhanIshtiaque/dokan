import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'package:url_launcher/url_launcher.dart';

import '../../../config/network_service/network_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/logger.dart';

class SignUpController extends GetxController {
  HttpService httpService = HttpService();
  var isLoading = false.obs;
  var countryCode = 'CA'.obs;
  var countryPhoneCode = '1'.obs;
  var phoneNo = ''.obs;
  var isChecked = true.obs;
  var isObscure = true.obs;
  var isObscure1 = true.obs;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordPageKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpPageKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();



  final phoneController = MaskedTextController(mask: '(000) 000-0000', );
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();

  final pinController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpService.init();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.gray700;
    }
    return Colors.black;
  }

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String passwordConfirmation,
      required String phoneNo}) async {
    final dataMap = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'accept_terms': 1,
      'phone':"+$phoneNo"
    };

    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.signUp, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;

          // logger.d(data);
          if (data["success"] == true) {
            Get.snackbar(
              "Welcome to morph",
              data["message"],
              backgroundColor: AppColors.green50,
              icon: const Icon(
                Icons.check_circle_rounded,
                size: 40,
              ),
            );
            Get.toNamed(Routes.VERIFYOTP);
          } else if (data["success"] == false) {
            Get.snackbar(
              'Opps',
              data["message"],
              backgroundColor: AppColors.red600,
              borderRadius: 12,
              icon: const Icon(
                Icons.error_outline,
                size: 40,
              ),
            );
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final dataMap = {'email': email, 'otp': otp};

    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.otpVerify, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;

           logger.d(data);
          if (data["success"] == true) {
            Get.snackbar(
              "Welcome to morph",
              data["message"],
              backgroundColor: AppColors.green50,
              icon: const Icon(
                Icons.check_circle_rounded,
                size: 40,
              ),
            );
            Get.offAllNamed(Routes.LOGIN);
          } else if (data["success"] == false) {
            Get.snackbar(
              'Opps',
              data["message"],
              backgroundColor: AppColors.red600,
              borderRadius: 12,
              icon: const Icon(
                Icons.error_outline,
                size: 40,
              ),
            );
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }


  Future<void> resendOtp({
    required String email,
  }) async {
    final dataMap = {'email': email, };

    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.resendOtp, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;

         // logger.d(data);
          if (data["success"] == true) {
            Get.snackbar(
              "Success",
              data["message"],
              backgroundColor: AppColors.green50,
              icon: const Icon(
                Icons.check_circle_rounded,
                size: 40,
              ),
            );

          } else if (data["success"] == false) {
            Get.snackbar(
              'Opps',
              data["message"],
              backgroundColor: AppColors.red600,
              borderRadius: 12,
              icon: const Icon(
                Icons.error_outline,
                size: 40,
              ),
            );
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }


  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
