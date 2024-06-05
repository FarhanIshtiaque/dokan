import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../config/network_service/network_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/logger.dart';

class SignUpController extends GetxController {
  HttpService httpService = HttpService();
  var isLoading = false.obs;
  var isObscure = true.obs;
  var isObscure1 = true.obs;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();




  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpService.init();
  }



  Future<void> userSignUp(
      {required String email,
      required String password,
      required String name,
  }) async {
    final dataMap = {
      'username': name,
      'email': email,
      'password': password,

    };

    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.signUp, method: Method.POST, params: dataMap);

      if (result != null) {
        if (result is Response) {
          var data = result.data;

           logger.d(data);
          if (result.statusCode ==200) {
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
          } else  {
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
