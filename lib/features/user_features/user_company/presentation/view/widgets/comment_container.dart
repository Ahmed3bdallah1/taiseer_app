import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/user_company/domain/entity/shipping_methods_entity.dart';
import '../../../../../../core/service/localization_service/localization_service.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../domain/entity/comment_entity.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

class CommentContainer extends StatelessWidget {
  final List<ShippingMethodsEntity>? shippingMethods;
  final CommentsEntity commentsEntity;

  const CommentContainer(
      {super.key, required this.commentsEntity, this.shippingMethods});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.grey1.withOpacity(.7)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ImageOrSvg(
                  commentsEntity.user.profilePhotoUrl ?? "",
                  pickImageOnNull: true,
                  height: 60,
                  width: 60,
                ),
                Gap(10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                commentsEntity.user.name ?? "",
                                style: AppFont.font16W600Black,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.gold,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      commentsEntity.rate.toString(),
                                      style: AppFont.font14W500Black,
                                    ),
                                    Gap(2.w),
                                    Icon(
                                      CupertinoIcons.star,
                                      color: AppColor.black,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          if (shippingMethods!.isNotEmpty)
                            ...shippingMethods!.map(
                              (e) => Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.primary.withOpacity(.2),
                                        border: Border.all(color: AppColor.primary),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      child: Text(
                                        localeService.isArabic?e.typeActivities?.infoAr??"":e.typeActivities?.infoEn??"",
                                        // e.typeActivities?.infoAr??"",
                                        style: AppFont.font10w400Primary,
                                      ),
                                    ),
                                  ),
                                  const Gap(2)
                                ],
                              ),
                            ),
                        ],
                      ),
                      Gap(6.h),
                      Divider(
                        color: AppColor.grey1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Text(
                            commentsEntity.comment,
                            style: AppFont.font12w500Grey2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
