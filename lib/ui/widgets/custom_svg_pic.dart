
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  final String svgPath;
  const CustomSvgPicture({super.key, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: BoxFit.contain,
      svgPath,
      width: 24,
      height: 24,
    );
  }
}