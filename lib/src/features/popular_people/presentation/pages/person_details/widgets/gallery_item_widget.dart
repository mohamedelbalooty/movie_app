import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/navigation/app_routes.dart';
import 'package:movie_app/src/core/utils/app_colors.dart';

class GalleryItemWidget extends StatelessWidget {
  const GalleryItemWidget({super.key, required this.filePath});

  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (filePath != null) {
          context.push(AppRoutes.imageDetails, extra: {'file_path': filePath});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor.withOpacity(.3),
          image: DecorationImage(
            image: NetworkImage(
              '${ApiConstants.imageBaseUrl}${ApiConstants.imageW342}${filePath}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
