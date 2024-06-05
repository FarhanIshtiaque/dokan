import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../../config/network_service/network_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/logger.dart';
import '../../../core/resource/local_storage/local_storage.dart';
import '../data/login_model.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;
  var isObscure = true.obs;
  HttpService httpService = HttpService();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormState> otpPageKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    httpService.init();
  }

  Future<void> userLogin(
      {required String email, required String password}) async {
    final dataMap = {
      'email': email,
      'password': password,
    };

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.login, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
          logger.d(data);

          if (data['success'] == true) {
            if (data['data']["user"]["OTP_verified"] == true) {
              LoginModel loginModel = LoginModel.fromJson(data);
              LocalStorage.saveToken(loginModel.data.accessToken.toString());
              LocalStorage.saveUsername(loginModel.data.user.firstName);
              LocalStorage.saveFullUsername('${loginModel.data.user.firstName} ${loginModel.data.user.lastName}');
              LocalStorage.saveUserId(loginModel.data.user.id);
              LocalStorage.saveEmail(loginModel.data.user.email);
              LocalStorage.saveAvatar(loginModel.data.user.avatar);
              LocalStorage.savePhoneNo(loginModel.data.user.phone.toString());

              Get.snackbar(
                "Welcome to Morph",
                loginModel.message,
                backgroundColor: AppColors.green50,
                icon: const Icon(
                  Icons.check_circle_rounded,
                  size: 40,
                ),
                shouldIconPulse: false,
              );
              Get.offAllNamed(Routes.DASHBOARD);
            } else {
              Get.snackbar(
                "Opps",
                data['message'],
                backgroundColor: AppColors.red50,
                icon: const Icon(
                  Icons.check_circle_rounded,
                  size: 40,
                ),
                shouldIconPulse: false,
              );
              Get.toNamed(Routes.LOGINVERIFYOTP);
            }
          } else if (data['success'] == false) {
            Get.snackbar(
              'Opps',
              data['message'],
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
            LoginModel loginModel = LoginModel.fromJson(data);
            await LocalStorage.saveToken(
                loginModel.data.accessToken.toString());
            await LocalStorage.saveUsername(loginModel.data.user.firstName);
            await LocalStorage.saveUserId(loginModel.data.user.id);
            await LocalStorage.saveEmail(loginModel.data.user.email);
            await LocalStorage.savePhoneNo(
                loginModel.data.user.phone.toString());
            await LocalStorage.saveAvatar(loginModel.data.user.avatar);
            LocalStorage.saveFullUsername('${loginModel.data.user.firstName} ${loginModel.data.user.lastName}');
            logger.d(LocalStorage.getPhoneNo());

            Get.snackbar(
              "Welcome to Morph",
              loginModel.message,
              backgroundColor: AppColors.green50,
              icon: const Icon(
                Icons.check_circle_rounded,
                size: 40,
              ),
              shouldIconPulse: false,
            );
            Get.offAllNamed(Routes.DASHBOARD);
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
    final dataMap = {
      'email': email,
    };

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
}
