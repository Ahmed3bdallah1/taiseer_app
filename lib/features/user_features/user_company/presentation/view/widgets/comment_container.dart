import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taiseer/config/app_font.dart';
import '../../../domain/entity/comment_entity.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

class CommentContainer extends StatelessWidget {
  final CommentsEntity commentsEntity;

  const CommentContainer({super.key, required this.commentsEntity});

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
                  commentsEntity.user.profilePhotoUrl??"",
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
                      Gap(10.h),
                      // Row(
                      //   children: [
                      //       ...commentsEntity.attributes!.map(
                      //         (e) => Row(
                      //           children: [
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                   color: AppColor.grey1,
                      //                   borderRadius:
                      //                       BorderRadius.circular(12.r)),
                      //               child: Padding(
                      //                 padding: EdgeInsets.symmetric(
                      //                   horizontal: 12,
                      //                   vertical: 2,
                      //                 ),
                      //                 child: Text(
                      //                   e.name,
                      //                   style: AppFont.font10w400Black,
                      //                 ),
                      //               ),
                      //             ),
                      //             Gap(2)
                      //           ],
                      //         ),
                      //       ),
                      //   ],
                      // ),
                      Gap(6.h),
                      Divider(
                        color: AppColor.grey1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Gap(6),
                      Row(
                        children: [
                          Text(
                            commentsEntity.comment ?? "",
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
