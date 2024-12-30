import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../config/app_color.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../company_features/add_company/presentation/manager/image_notifier.dart';
import '../../../../user_company/data/model/company_details_model.dart';
import '../../../../user_company/data/model/company_model.dart';
import '../../../../user_company/presentation/view/shipping_method_tile.dart';

class ShipmentTypeAndImagesWidget extends ConsumerStatefulWidget {
  final UserCompanyModel2 companyModel;
  final CompanyDetailsModel companyDetailsModel;

  const ShipmentTypeAndImagesWidget(
      {super.key,
        required this.companyModel,
        required this.companyDetailsModel});

  @override
  ConsumerState<ShipmentTypeAndImagesWidget> createState() =>
      _ShipmentTypeAndImagesWidgetState();
}

class _ShipmentTypeAndImagesWidgetState extends ConsumerState<ShipmentTypeAndImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(24.h),
        Row(
          children: [
            const Icon(
              CupertinoIcons.cube_box,
              color: AppColor.primary,
            ),
            Gap(10.w),
            Text(
              "Select service".tr,
              style: AppFont.font18W700Black,
            ),
            Gap(10.w),
            ReactiveFormConsumer(builder: (context, form, _) {
              final value =
                  form.control("typeActivity_id").value as List<int>? ?? [];
              if (form.control("typeActivity_id").value == null) {
                return const SizedBox.shrink();
              }
              return Container(
                decoration: BoxDecoration(
                    color: AppColor.grey1,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(widget.companyModel.typeActivityCompanies!
                      .firstWhereOrNull((e) => value.contains(e.id))
                      ?.typeActivities
                      ?.infoAr ??
                      ''),
                ),
              );
            })
          ],
        ),
        Gap(16.h),
        SizedBox(
          height: 95,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ReactiveFormConsumer(
                        builder: (context, form, _) {
                          final value = form.control("typeActivity_id").value
                          as List<int>? ??
                              [];
                          // if (index !=
                          //     widget.companyDetailsModel.typeActivityCompanies
                          //         .length) {
                            final isSelected = value.contains(widget
                                .companyDetailsModel
                                .typeActivityCompanies[index]
                                .id);
                            return ShippingMethodTile(
                              color: AppColor.grey2,
                              shippingMethodsEntity: widget.companyDetailsModel
                                  .typeActivityCompanies[index],
                              hideSelectedItem: false,
                              isSelected: isSelected,
                              onTap: () {
                                if (isSelected) {
                                  value.removeWhere((e) =>
                                  e ==
                                      widget.companyDetailsModel
                                          .typeActivityCompanies[index].id);
                                  form
                                      .control("typeActivity_id")
                                      .updateValue(value);
                                } else {
                                  value.add(widget.companyDetailsModel
                                      .typeActivityCompanies[index].id);
                                  form
                                      .control("typeActivity_id")
                                      .updateValue(value);
                                }
                                setState(() {});
                              },
                            );
                          // } else {
                          //   return ReactiveFormConsumer(
                          //     builder: (context, form, _) {
                          //       bool isFastSelected =
                          //           form.control("is_fast_shipping").value ==
                          //               true;
                          //       return FastShippingMethodTile(
                          //         color: Colors.white,
                          //         isSelected: isFastSelected,
                          //         onTap: () {
                          //           form.control("is_fast_shipping").value =
                          //           !isFastSelected;
                          //         },
                          //       );
                          //     },
                          //   );
                          // }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gap(10.w);
                    },
                    itemCount: widget
                        .companyDetailsModel.typeActivityCompanies.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(24.h),
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.image,
              color: AppColor.primary,
            ),
            Gap(10.w),
            Text(
              "Shipment images".tr,
              style: AppFont.font18W700Black,
            ),
          ],
        ),
        Gap(16.h),
        ReactiveFormConsumer(builder: (context, form, _) {
          final images =
              form.control("shipping_images").value as List<String>? ?? [];
          final isLoadingImages =
          ref.watch(isLoadingProvider("shipping_images"));
          ref.watch(uploadFileNotifierProvider3(''));
          final newImageProvider =
          ref.read(uploadFileNotifierProvider3('').notifier);
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      final imageFile = await newImageProvider.pickImage();
                      if (imageFile != null) {
                        try {
                          ref
                              .read(isLoadingProvider("add_button").notifier)
                              .state = true;

                          final uploaded = await newImageProvider
                              .uploadFile(File(imageFile.path));
                          images.add(uploaded);
                          form.control("shipping_images").value = images;
                        } finally {
                          if (context.mounted) {
                            ref
                                .read(isLoadingProvider("add_button").notifier)
                                .state = false;
                          }
                        }
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 50,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Gap(6.w),
                  ...images.asMap().entries.map(
                        (entry) {
                      final imageUrl = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.primary.withOpacity(.8),
                              ),
                              child: ImageOrSvg(
                                width: 80,
                                height: 80,
                                // fit: BoxFit.fill,
                                imageUrl,
                                isLoading: isLoadingImages,
                              ),
                            ),
                            PositionedDirectional(
                                bottom: 0,
                                end: 0,
                                child: InkWell(
                                  onTap: () {
                                    final list = List<String>.from(
                                        form.control('shipping_images').value);
                                    list.remove(imageUrl);
                                    form
                                        .control('shipping_images')
                                        .updateValue(list);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.danger,
                                        borderRadius:
                                        const BorderRadiusDirectional.only(
                                            bottomEnd: Radius.circular(10),
                                            topStart: Radius.circular(8))),
                                    child: Icon(
                                      Icons.close,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        Gap(24.h),
      ],
    );
  }
}