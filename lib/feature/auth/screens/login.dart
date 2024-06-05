
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../config/routes/app_pages.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/helper/validator.dart';
import '../../../core/resource/widgets/primary_button.dart';
import '../../../core/resource/widgets/primary_textfield.dart';
import '../controller/login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 80.h,),
          SvgPicture.asset(
              AppAssets.dokanLogo,
          ),
          SizedBox(height: 60.h,),
          const Text('Sign In',
          style: AppTextStyle.headingSmall,
          ),
          SizedBox(height: 20.h,),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.horizontalPadding),
            child: Form(
              key: loginController.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    controller: loginController.emailController,
                    validator: (v) => Validator.validateEmail(v!),
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: "Type your password",
                      obscureText: loginController.isObscure.value,
                      controller: loginController.passwordController,
                      validator: (v) => Validator.validatePassword(v!),
                      keyboardType: TextInputType.text,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            loginController
                                .isObscure(!loginController.isObscure.value);
                          },
                          child: Icon(
                            loginController.isObscure.value
                                ? Iconsax.eye4
                                : Iconsax.eye_slash4,
                            color:AppColors.gray300,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.FORGOTPASSWORD);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: AppTextStyle.labelSmall.copyWith(
                              color: AppColors.gray500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            ' Click here',
                            style: AppTextStyle.labelSmall.copyWith(
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.horizontalPadding),
                  child: PrimaryButton(
                      isElevated: true,

                      onPressed: () {
                        final isValid =
                            loginController.key.currentState!.validate();

                        if (isValid) {
                          loginController.userLogin(
                              email:
                                  loginController.emailController.text.trim(),
                              password: loginController.passwordController.text
                                  .trim());
                        }
                      },
                      buttonNameWidget: Obx(
                        () => loginController.isLoading.value
                            ? Lottie.asset(AppAssets.loaderPurple, width: 35)
                            :  Text(
                          'Login',
                          style: AppTextStyle.displayXXSmall.copyWith(color: AppColors.white),

                        ),
                      )),
                ),
                const SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Don\'t an have account',
                    style: AppTextStyle.bodyMedium
                        .copyWith(color: AppColors.gray600),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up now',
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
    );
  }
}
