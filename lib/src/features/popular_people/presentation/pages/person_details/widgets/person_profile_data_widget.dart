import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/utils/app_colors.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';

class PersonProfileDataWidget extends StatelessWidget {
  const PersonProfileDataWidget({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 130,
          width: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        '${ApiConstants.imageBaseUrl}${ApiConstants.imageW342}${person.profilePath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 10,
                end: 0,
                start: 70,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
        Text(
          person.name ?? '',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
