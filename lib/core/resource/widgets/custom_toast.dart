import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color color;
  final IconData iconData;

  const CustomToast({super.key, required this.message, required this.color, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100) ),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData,color: color,),
            const SizedBox(width: 12.0),
            Text(
              message,
              style: AppTextStyle.bodyMedium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
