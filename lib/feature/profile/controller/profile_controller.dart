import 'package:dokan/core/resource/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../config/network_service/network_service.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/logger.dart';
import '../data/profile_data_model.dart';

class ProfileController extends GetxController{
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  var isLoading = false.obs;
  HttpService httpService = HttpService();
   var userName = ''.obs;
   var email = ''.obs;
   var profileId = 0.obs;


  @override
  void onInit() {
    super.onInit();
    httpService.init();
    userName(LocalStorage.getUsername());
    email(LocalStorage.getEmail());
    getProfile();
  }


  Future<void> getProfile(
     ) async {




    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.getProfile, method: Method.GET, params: {}, authToken: LocalStorage.getToken());

      if (result != null) {
        if (result is Response) {
          var data = result.data;

        //  logger.d(data);
          if (result.statusCode ==200) {
            ProfileDataModel profileDataModel = ProfileDataModel.fromJson(data);
            profileId(profileDataModel.id);
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }


  Future<void> updateProfile(
      {required String firstName,
        required String lastName,

      }) async {
    final dataMap = {
      'first_name': firstName,
      'last_name': lastName,


    };

    logger.d(dataMap);

    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiEndPoints.profileUpdate+profileId.toString(), method: Method.POST, params: dataMap, authToken: LocalStorage.getToken());

      if (result != null) {
        if (result is Response) {
          var data = result.data;

       //   logger.d(data);
          if (result.statusCode ==200) {
            Get.snackbar(
              "Success",
              "Your profile updated",
              backgroundColor: AppColors.green50,
              icon: const Icon(
                Icons.check_circle_rounded,
                size: 40,
              ),
            );
            Get.back();
          } else  {
            Get.snackbar(
              'Opps',
              'Something went wrong',
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