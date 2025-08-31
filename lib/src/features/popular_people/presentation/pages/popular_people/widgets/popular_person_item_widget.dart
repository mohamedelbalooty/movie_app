import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/navigation/app_routes.dart';
import 'package:movie_app/src/core/utils/app_colors.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';

class PopularPersonItemWidget extends StatelessWidget {
  const PopularPersonItemWidget({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (person.id != null) {
          context.push(AppRoutes.personDetails, extra: {'person': person});
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage:
                  '${ApiConstants.imageBaseUrl}${ApiConstants.imageW342}${person.profilePath}'
                      .isNotEmpty
                  ? NetworkImage(
                      '${ApiConstants.imageBaseUrl}${ApiConstants.imageW342}${person.profilePath}',
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    person.name ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    person.knownForDepartment ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'known_for'.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey600Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 115,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90,
                            width: 76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${ApiConstants.imageBaseUrl}${ApiConstants.imageW342}${person.knownFor[index].posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 76,
                            child: Text(
                              person.knownFor[index].title ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: person.knownFor.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
