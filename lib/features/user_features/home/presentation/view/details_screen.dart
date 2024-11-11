import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/core/service/loading_provider.dart';
import 'package:learning/features/user_features/home/presentation/view/widgets/silder_item_widget.dart';
import 'package:learning/features/user_features/order/presentation/view/order_screen.dart';
import 'package:learning/features/user_features/user_company/domain/entity/shipping_methods_entity.dart';
import 'package:learning/ui/shared_widgets/custom_filled_button.dart';
import 'package:learning/ui/shared_widgets/custom_outlined_button.dart';
import 'package:learning/ui/shared_widgets/custom_slider.dart';
import 'package:learning/ui/shared_widgets/custom_logo_app_bar.dart';
import 'package:learning/ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/container_button.dart';
import '../../../../shared/notifications/presentation/view/notifications_screen.dart';
import '../../../user_company/data/model/company_model.dart';
import '../../../user_company/presentation/view/shipping_method_tile.dart';
import '../../../user_company/presentation/view/widgets/comment_container.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final UserCompanyModel? companyModel;

  const DetailsScreen({
    super.key,
    required this.companyModel,
  });

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: AppColor.primaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Column(
              children: [
                SizedBox(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 160.h,
                        width: MediaQuery.of(context).size.width,
                        child: ImageOrSvg(
                            widget.companyModel!.backgroundImage ?? "",
                            isLocal: true,
                            fit: BoxFit.fitWidth),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CustomLogoAppbar(
                          scrollController: controller,
                          customTitleWidget: Text(
                            widget.companyModel!.title ?? "",
                          ),
                          buttonWidget: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ContainerButton(
                              color: Colors.transparent,
                              size: 50,
                              iconColor: AppColor.primary,
                              icon: Icons.notifications_active,
                              onTap: () =>
                                  Get.to(() => const NotificationsScreen()),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100.h,
                        left: 20.w,
                        right: 20.w,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(color: AppColor.grey1),
                              borderRadius: BorderRadius.circular(24.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.grey1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Row(
                                      children: [
                                        ImageOrSvg(
                                          widget.companyModel!.image ?? "",
                                          isLocal: true,
                                        ),
                                        Gap(10.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.companyModel!.title ?? "",
                                              style: AppFont.font20W600Black,
                                              textAlign: TextAlign.center,
                                            ),
                                            Gap(14.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ...widget
                                                    .companyModel!.attributes!
                                                    .map(
                                                  (e) => Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColor.grey1,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 2.h,
                                                          ),
                                                          child: Text(
                                                            e.name,
                                                            style: AppFont
                                                                .font10w400Black,
                                                          ),
                                                        ),
                                                      ),
                                                      Gap(2.w)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border:
                                            Border.all(color: AppColor.grey1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.star,
                                                  color: AppColor.orange,
                                                ),
                                                Gap(30.w),
                                                Text(
                                                  widget.companyModel!.rating
                                                      .toString(),
                                                  style:
                                                      AppFont.font20W600Black,
                                                )
                                              ],
                                            ),
                                            Gap(10.h),
                                            Text(
                                              "Ratings".tr,
                                              style: AppFont.font14W600Black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border:
                                            Border.all(color: AppColor.grey1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.hand_thumbsup,
                                                  color: AppColor.green,
                                                ),
                                                Gap(30.w),
                                                Text(
                                                  widget.companyModel!.likes
                                                      .toString(),
                                                  style:
                                                      AppFont.font20W600Black,
                                                )
                                              ],
                                            ),
                                            Gap(10.h),
                                            Text(
                                              "Likes".tr,
                                              style: AppFont.font14W600Black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border:
                                            Border.all(color: AppColor.grey1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  FontAwesomeIcons.ship,
                                                  color: AppColor.primary,
                                                ),
                                                Gap(30.w),
                                                Text(
                                                  widget.companyModel!.shipment
                                                      .toString(),
                                                  style:
                                                      AppFont.font20W600Black,
                                                )
                                              ],
                                            ),
                                            Gap(10.h),
                                            Text(
                                              "Shipments".tr,
                                              style: AppFont.font14W600Black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.slider_horizontal_below_rectangle,
                            color: AppColor.primary,
                          ),
                          Gap(5.w),
                          Text(
                            "Sponsors ".tr,
                            style: AppFont.font18W700Black,
                          ),
                          Text(
                            widget.companyModel!.title ?? "",
                            style: AppFont.font18W700Black,
                          )
                        ],
                      ),
                      CustomSlider(
                        widget.companyModel!.ads!
                            .map((e) => SliderItem(e))
                            .toList(),
                        // height: 170.h,
                        autoPlay: true,
                        onPageChanged: (index, _) {
                          ref.read(sliderIndexProvider.notifier).state = index;
                        },
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.info,
                            color: AppColor.primary,
                          ),
                          Gap(5.w),
                          Text(
                            "About company".tr,
                            style: AppFont.font18W700Black,
                          ),
                        ],
                      ),
                      Gap(10.h),
                      Text(
                        widget.companyModel!.description ?? "",
                        style: AppFont.font14W500Grey2,
                        textAlign: TextAlign.start,
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.info,
                            color: AppColor.primary,
                          ),
                          Gap(5.w),
                          Text(
                            "About company".tr,
                            style: AppFont.font18W700Black,
                          ),
                        ],
                      ),
                      Gap(10.h),
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ShippingMethodTile(
                                color: AppColor.grey2,
                                shippingMethodsEntity: widget
                                    .companyModel!.shippingMethods![index]);
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(10);
                          },
                          itemCount:
                              widget.companyModel!.shippingMethods?.length??0,
                        ),
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          const Icon(
                            Icons.comment,
                            color: AppColor.primary,
                          ),
                          Gap(5.w),
                          Text(
                            "Users's opinions".tr,
                            style: AppFont.font18W700Black,
                          ),
                        ],
                      ),
                      Gap(10.h),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.companyModel!.comment!.length,
                            separatorBuilder: (context, index) {
                              return const Gap(10);
                            },
                            itemBuilder: (context, index) {
                              return CommentContainer(
                                  commentsEntity:
                                      widget.companyModel!.comment![index]);
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomFilledButton(
                text: "Order".tr,
                onPressed: () => Get.to(() => OrderScreen(
                      companyModel: widget.companyModel!,
                    )),
              ),
            ),
            const Gap(10),
            Expanded(
              flex: 1,
              child: CustomOutlinedButton(
                widget: const Icon(
                  Icons.add,
                  color: AppColor.primary,
                ),
                text: "Follow".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
