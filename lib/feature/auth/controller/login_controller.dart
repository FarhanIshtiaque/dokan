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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    httpService.init();
  }

  Future<void> userLogin(
      {required String email, required String password}) async {
    final dataMap = {
      'username': email,
      'password': password,
    };
    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.login, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
       //   logger.d(data);

          if (result.statusCode == 200) {
                LoginModel loginModel = LoginModel.fromJson(data);
                LocalStorage.saveToken(loginModel.token);
                LocalStorage.saveUsername(loginModel.userDisplayName);


                LocalStorage.saveEmail(loginModel.userEmail);


                Get.snackbar(
                  "Welcome to Dokan",
                  "Successfully login",
                  backgroundColor: AppColors.green50,
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    size: 40,
                  ),
                  shouldIconPulse: false,
                );
                Get.offAllNamed(Routes.HOME);


            }

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

        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }


}
