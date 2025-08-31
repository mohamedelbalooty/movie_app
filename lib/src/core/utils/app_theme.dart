import "package:flutter/material.dart";
import "package:movie_app/src/core/utils/app_assets.dart";
import "package:movie_app/src/core/utils/app_colors.dart";
import "package:movie_app/src/core/utils/app_styles.dart";

abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    fontFamily: AppAssets.tajawalFontFamily,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    appBarTheme: AppBarTheme(
      elevation: 4,
      centerTitle: true,
      backgroundColor: AppColors.appBarColor,
      foregroundColor: AppColors.appBarColor,
      titleTextStyle: AppStyles.appbarTitleStyle(),
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      error: AppColors.errorColor,
    ),
  );
}
