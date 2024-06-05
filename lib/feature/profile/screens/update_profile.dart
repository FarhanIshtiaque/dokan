import 'package:dokan/core/resource/widgets/primary_button.dart';
import 'package:dokan/feature/profile/controller/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/helper/validator.dart';
import '../../../core/resource/widgets/primary_textfield.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Update Profile',
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 36,
            ),
            DottedBorder(
              color: const Color(0xFFFFADAD),
              radius: const Radius.circular(12),
              dashPattern: const [4, 2, 4, 3],
              borderType: BorderType.Circle,
              padding: EdgeInsets.all(8),
              child: const ProfilePicture(
                name: 'Aditya Dharmawan Saputra',
                radius: 64,
                fontsize: 42,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const Text(
              'John Smith',
              style: AppTextStyle.headingSmall,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'info@johnsmith.com',
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.gray700),
            ),
            const SizedBox(
              height: 36,
            ),
            Form(
              key: profileController.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'First Name',
                    style: AppTextStyle.labelMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryTextField(
                    prefixIcon: const HeroIcon(HeroIcons.user),
                    hintText: "Your first name",
                    controller:
                    profileController.firstNameController,
                    validator: (v) =>
                        Validator.validateFirstName(v!),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Last Name',
                    style: AppTextStyle.labelMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryTextField(
                    prefixIcon: const HeroIcon(HeroIcons.user),
                    hintText: "Your last name",
                    controller: profileController.lastNameController,
                    validator: (v) =>Validator.validateLastName(v!),
                  ),


                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24,),
            PrimaryButton(onPressed: (){}, buttonNameWidget: Obx(
                  () => profileController.isLoading.value
                  ? Lottie.asset(AppAssets.loaderPurple, width: 35)
                  :  Text(
                'Login',
                style: AppTextStyle.displayXXSmall.copyWith(color: AppColors.white),

              ),
            ))

          ],
        ),
      ),
    );
  }
}
