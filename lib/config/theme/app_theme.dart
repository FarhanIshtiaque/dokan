
import 'package:flutter/material.dart';


import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

ThemeData theme() {
  return ThemeData(
   useMaterial3: false,
    errorColor: AppColors.red600,
    primarySwatch: Colors.blue,
    fontFamily: 'Nunito',
    appBarTheme: appBarTheme(),
    backgroundColor: AppColors.white

  );
}

AppBarTheme appBarTheme() {
  return  AppBarTheme(
    titleSpacing: 24,
    color: Colors.white,
    elevation: 0,
   // toolbarHeight: 70,
   // shadowColor: AppColors.gray50,
    centerTitle: true,

    iconTheme: const IconThemeData(
      color: AppColors.black,

    ),
    titleTextStyle: AppTextStyle.headingSmall.copyWith(color: AppColors.black),
  );
}
