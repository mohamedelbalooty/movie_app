import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/show_image/cubit/show_image_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/widgets/fading_image_widget.dart';

import 'widgets/download_button.dart';

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
      floatingActionButton: DownloadButton(
        imageUrl: context.select<ShowImageCubit, String>(
          (cubit) => cubit.filePath,
        ),
      ),
    );
  }
}
