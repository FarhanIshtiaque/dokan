import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:iconsax/iconsax.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../config/routes/app_pages.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/helper/string_helper.dart';
import '../../../core/helper/validator.dart';
import '../../../core/resource/widgets/primary_button.dart';
import '../../../core/resource/widgets/primary_textfield.dart';
import '../controller/sign_up_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          splashRadius: 26,
          onPressed: () {
            Get.back();
          },
          icon: const HeroIcon(
            HeroIcons.arrowLeft,
            style: HeroIconStyle.solid,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SvgPicture.asset(
            //     AppAssets.loginShape
            // )
            SizedBox(height: 80.h,),
            SvgPicture.asset(
              AppAssets.dokanLogo,
            ),
            SizedBox(height: 60.h,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.horizontalPadding),
              child: Form(
                key: signUpController.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: AppTextStyle.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                      prefixIcon: HeroIcon(HeroIcons.user),
                      hintText: "Type your name",
                      controller:
                      signUpController.firstNameController,
                      validator: (v) =>
                          Validator.validateFirstName(v!),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Email',
                      style: AppTextStyle.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                      prefixIcon: const HeroIcon(HeroIcons.envelope),
                      hintText: "Type your email",
                      controller: signUpController.emailController,
                      validator: (v) => Validator.validateEmail(v!),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Password',
                      style: AppTextStyle.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                          () => PrimaryTextField(
                            prefixIcon: const HeroIcon(HeroIcons.lockClosed),
                        obscureText: signUpController.isObscure.value,
                        hintText: "Type your password",
                        controller: signUpController.passwordController,
                        validator: (v) => Validator.validatePassword(v!),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController
                                  .isObscure(!signUpController.isObscure.value);
                            },
                            child: Icon(
                              signUpController.isObscure.value
                                  ? Iconsax.eye4
                                  : Iconsax.eye_slash4,
                              color: AppColors.gray400,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Confirm Password',
                      style: AppTextStyle.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                          () => PrimaryTextField(
                            prefixIcon: const HeroIcon(HeroIcons.lockClosed),
                        obscureText: signUpController.isObscure1.value,
                        controller: signUpController.passwordCheckController,
                        hintText: "Type your password again",
                        validator: (v) => Validator.validateConfirmPassword(
                            v!, signUpController.passwordController.text),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController.isObscure1(
                                  !signUpController.isObscure1.value);
                            },
                            child: Icon(
                              signUpController.isObscure1.value
                                  ? Iconsax.eye4
                                  : Iconsax.eye_slash4,
                              color: AppColors.gray400,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.horizontalPadding),
                    child: PrimaryButton(
                        onPressed: () {
                          final isValid =
                              signUpController.key.currentState!.validate();

                          if (isValid) {
                            signUpController.phoneNo(
                                signUpController.countryPhoneCode.value +
                                    StringHelper.unMask(
                                        signUpController.phoneController.text));
                            Get.toNamed(Routes.CREATEPASSWORD);
                          }
                        },



                        buttonNameWidget: Text(
                          'Sign Up',
                          style: AppTextStyle.labelLarge
                              .copyWith(color: AppColors.white),

                        )),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Already have an account',
                      style: AppTextStyle.bodyMedium
                          .copyWith(color: AppColors.gray600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: AppTextStyle.bodyMedium
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
