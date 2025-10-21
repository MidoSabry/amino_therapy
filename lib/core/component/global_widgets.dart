import 'package:flutter/material.dart';

import '../data/constants/app_colors.dart';
import '../data/constants/global_obj.dart';
import '../global/enums/global_enum.dart';
import '../global/global_func.dart';
import 'custom_loader/custom_loader.dart';


Widget customLoader({double? size, LoadingShape? loadingShape}) {
  return CustomLoader(
    loadingShape: loadingShape ?? LoadingShape.fadingCircle,
    color: Theme.of(Get.context!).colorScheme.inversePrimary,
    // color: isDark?AppColors.whiteColor:AppColors.primaryColor,
    size: size ?? 50,
  );
}

Decoration commonDecoration({
  Color? color,
  Gradient? gradient,
  Color shadowColor = Colors.transparent,
  double spreadRadius = 5,
  double blurRadius = 0,
  Offset offset = const Offset(0, 4),
  Color? borderColor,
  double borderRadius = 4.0,
}) {
  return BoxDecoration(
    color:
        color ?? (isDark ? AppColors.darkFieldBackgroundColor : Colors.white),
    gradient: gradient,
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset,
      ),
    ],
    border: Border.all(
      color:
          borderColor ??
          (isDark ? AppColors.darkBorderColor : AppColors.grayColor200),
    ),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
