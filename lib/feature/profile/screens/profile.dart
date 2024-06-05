import 'package:dokan/config/routes/app_pages.dart';
import 'package:dokan/core/constants/app_colors.dart';
import 'package:dokan/core/constants/app_values.dart';
import 'package:dokan/core/constants/text_styles.dart';
import 'package:dokan/feature/profile/controller/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:iconly/iconly.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'My Account',
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
              dashPattern: [4, 2, 4, 3],
              borderType: BorderType.Circle,
              padding: EdgeInsets.all(8),
              child: ProfilePicture(
                name: 'Aditya Dharmawan Saputra',
                radius: 64,
                fontsize: 42,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Column(
                children: [
                  ListTile(
                    title: Text(
                      "Account",
                      style: AppTextStyle.labelLarge,
                    ),
                    leading: Icon(IconlyLight.profile),
                    trailing: HeroIcon(HeroIcons.chevronRight),
                    onTap: (){Get.toNamed(Routes.UPDATEPROFILE);},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
