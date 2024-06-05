import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SvgPicture.asset(
            //     AppAssets.loginShape
            // )
            SizedBox(
              height: 296.h,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.loginShape1,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Welcome to'),
                        const SizedBox(
                          height: 8,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(AppAssets.morph)),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 64,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.headingSmall
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Create your account with few easy steps',
                          style: AppTextStyle.labelSmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.horizontalPadding),
              child: Form(
                key: signUpController.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
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
                                hintText: "First name",
                                controller:
                                    signUpController.firstNameController,
                                validator: (v) =>
                                    Validator.validateFirstName(v!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Last Name',
                                style: AppTextStyle.labelMedium,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PrimaryTextField(
                                hintText: "Last name",
                                validator: (v) =>
                                    Validator.validateLastName(v!),
                                controller: signUpController.lastNameController,
                              ),
                            ],
                          ),
                        ),
                      ],
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
                      hintText: "Type your email",
                      controller: signUpController.emailController,
                      validator: (v) => Validator.validateEmail(v!),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Phone',
                      style: AppTextStyle.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 88,
                          child: PrimaryTextField(
                            onTap: () {
                              showCountryPicker(
                                countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: Get.height * .7,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8)),
                                    inputDecoration: InputDecoration(
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? AppColors.gray500
                                                  : AppColors.gray200),
                                      suffixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? AppColors.gray500
                                                  : AppColors.gray200),
                                      fillColor: AppColors.gray100,
                                      filled: true,
                                      hintStyle: AppTextStyle.bodyMedium
                                          .copyWith(color: AppColors.gray700),
                                      //  hintStyle: bodyMedium14.copyWith(color: AppColors.gray200),
                                      contentPadding: const EdgeInsets.only(
                                          left: 16, top: 11, bottom: 11),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: AppColors.gray100,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: AppColors.gray500,
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: AppColors.red300,
                                            width: 1.0),
                                      ),
                                    )),

                                context: context,
                                useSafeArea: true,
                                showPhoneCode: true,
                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  //   print('Select country: ${country.displayName}');
                                  //     logger.d(country.phoneCode);
                                  signUpController
                                      .countryCode(country.countryCode);
                                  signUpController
                                      .countryPhoneCode(country.phoneCode);
                                },
                              );
                            },
                            prefixIcon: Transform.scale(
                              scale: .5,
                              child: Obx(
                                () => CountryFlag.fromCountryCode(
                                  signUpController.countryCode.value,
                                  height: 18,
                                  width: 24,
                                ),
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.gray700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: PrimaryTextField(
                            hintText: "Type your phone no",
                            controller: signUpController.phoneController,
                            validator: (v) => Validator.validateMobile(v!),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(
                              signUpController.getColor),
                          value: signUpController.isChecked.value,
                          onChanged: (bool? value) {
                            signUpController.isChecked(value!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'I agree to the ',
                        style: AppTextStyle.labelMedium
                            .copyWith(color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          signUpController.launchURL(
                              'https://morphmydesign.com/privacy-policy');
                        },
                        child: Text(
                          'terms and conditions',
                          style: AppTextStyle.labelMedium.copyWith(
                              color: AppColors.black,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
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
                        isRounded: true,
                        isElevated: true,
                        color: AppColors.white,
                        buttonNameWidget: GradientText(
                          'Next',
                          style: AppTextStyle.labelLarge
                              .copyWith(color: AppColors.white),
                          colors: const [Color(0xffFF58A8), Color(0xff6100FF)],
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
