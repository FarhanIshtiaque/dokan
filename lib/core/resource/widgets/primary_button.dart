import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_values.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonNameWidget,
    this.large = true,
    this.color = AppColors.sunsetOrange, this.isRounded = false,  this.isElevated = false,
  });
  final VoidCallback? onPressed;

  final Widget buttonNameWidget;
  final bool large;
  final Color? color;
  final bool isRounded;
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      disabledColor: AppColors.gray50,
      color: color,
      splashColor: AppColors.white.withOpacity(.2),
      elevation: isElevated?3:0,


      height: large ? 56 : 40,
      minWidth: double.infinity,
      onPressed: onPressed,


      shape: RoundedRectangleBorder(
          borderRadius:isRounded? BorderRadius.circular(100) :BorderRadius.circular(AppValues.buttonRadius)),
      child: buttonNameWidget,
    );
  }
}
