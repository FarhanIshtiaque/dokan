import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class GradientIcon extends StatelessWidget {
  final HeroIcons icon;
  final double size;
  final Gradient gradient;

  GradientIcon({required this.icon, required this.size, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return gradient.createShader(bounds);
        },
        child:

        HeroIcon( icon,
          size: size,
          color: Colors.white, )


    );
  }
}