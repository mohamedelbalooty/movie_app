import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:movie_app/src/core/utils/app_assets.dart";

import "app_colors.dart";

abstract class AppStyles {
  static TextStyle appbarTitleStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    double? height,
  }) => TextStyle(
    color: color ?? AppColors.whiteColor,
    fontSize: fontSize ?? 20.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontFamily: fontFamily ?? AppAssets.tajawalFontFamily,
    height: height ?? 1.5,
    overflow: TextOverflow.ellipsis,
  );
}
