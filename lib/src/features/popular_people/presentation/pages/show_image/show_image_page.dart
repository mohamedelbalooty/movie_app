import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/utils/app_colors.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/show_image/cubit/show_image_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/widgets/fading_image_widget.dart';

class ShowImagePage extends StatelessWidget {
  const ShowImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ShowImageCubit, ShowImageState>(
        builder: (context, state) {
          switch (state) {
            case ShowImageInitial():
              return FadingImageWidget(
                height: double.infinity,
                width: double.infinity,
                imageUrl:
                    '${ApiConstants.imageBaseUrl}${ApiConstants.imageOriginal}${state.filePath}',
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.download_outlined,
          color: AppColors.whiteColor,
          size: 24.sp,
        ),
      ),
    );
  }
}
