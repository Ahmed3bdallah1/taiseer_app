import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/company_features/add_company/data/model/add_company_model.dart';
import 'package:taiseer/features/shared/auth/domain/entities/auth_entity.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/service/image_picker_cropper.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../main.dart';
import '../../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../user_features/profile/presentation/manager/upload_file_notifier.dart';
import '../../../../../user_features/user_company/domain/entity/attributes_entity.dart';

class CompanyActivitiesInfo extends StatefulWidget {
  final ScrollController scrollController;
  final AddCompanyModel addCompanyModel;

  const CompanyActivitiesInfo(
      {super.key,
      required this.scrollController,
      required this.addCompanyModel});

  @override
  State<CompanyActivitiesInfo> createState() => _CompanyActivitiesInfoState();
}

class _CompanyActivitiesInfoState extends State<CompanyActivitiesInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Shipping countries".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final value =
                  form.control("countries").value as List<CountryEntity>;
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return MultiSelectBottomSheet(
                        selectedItemsTextStyle: AppFont.font12W600Green,
                        items: [
                          ...widget.addCompanyModel.countries!
                              .map((e) => MultiSelectItem(e, e.title ?? ""))
                        ],
                        initialValue: form.control("countries").value,
                        onConfirm: (value) {
                          form.control("countries").value = value;
                        },
                        maxChildSize: 0.8,
                      );
                    },
                  );
                },
                child: value.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColor.gray_3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select shipping countries".tr),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      )
                    : IgnorePointer(
                        ignoring: true,
                        child: MultiSelectChipDisplay(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColor.gray_3),
                          ),
                          // scroll: true,
                          chipColor: AppColor.green1.withOpacity(.2),
                          items: [
                            ...value.map(
                              (e) => MultiSelectItem(
                                value,
                                e.title ?? "",
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
          Gap(16.h),
          Text("Shipping type".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final value =
                  form.control("attributes").value as List<AttributesEntity>;
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return MultiSelectBottomSheet(
                        selectedItemsTextStyle: AppFont.font12W600Green,
                        items: [
                          ...widget.addCompanyModel.attributes!
                              .map((e) => MultiSelectItem(e, e.name ?? ""))
                        ],
                        initialValue: form.control("attributes").value,
                        onConfirm: (value) {
                          form.control("attributes").value = value;
                        },
                        maxChildSize: 0.9,
                      );
                    },
                  );
                },
                child: value.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColor.gray_3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select shipping methods".tr),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      )
                    : IgnorePointer(
                        ignoring: true,
                        child: MultiSelectChipDisplay(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColor.gray_3),
                          ),
                          // scroll: true,
                          chipColor: AppColor.green1.withOpacity(.2),
                          items: [
                            ...value.map(
                              (e) => MultiSelectItem(
                                value,
                                e.name ?? "",
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
          Gap(16.h),
          CustomTextField(
            formControlName: "manager_name",
            labelText: ("Manager name".tr),
            hintText: ("Manager name".tr),
            borderRadius: BorderRadius.circular(12),
          ),
          Gap(16.h),
          Text("Personal license image".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final image = form.control("personal_id_image").value as String?;
              return Consumer(builder: (context, ref, _) {
                ref.watch(uploadFileNotifierProvider2(image));
                final newImageProvider =
                    ref.read(uploadFileNotifierProvider2(image).notifier);
                return InkWell(
                    onTap: () async {
                      final imageFile = await newImageProvider.pickImage();
                      if (imageFile != null) {
                        try {
                          ref
                              .read(
                                  isLoadingProvider("set_personal_id").notifier)
                              .state = true;

                          final uploaded = await newImageProvider
                              .uploadFile(File(imageFile.path));
                          form.control('personal_id_image').value = uploaded;
                        } finally {
                          ref
                              .read(
                                  isLoadingProvider("set_personal_id").notifier)
                              .state = false;
                        }
                      }
                    },
                    child: image != null ||
                            ref.watch(isLoadingProvider("set_personal_id"))
                        ? Stack(
                            children: [
                              ImageOrSvg(
                                image ?? "/assets/img/default.png",
                                fit: BoxFit.fitHeight,
                                height: 200,
                                isCircleLoading: false,
                                width: double.infinity,
                                isLoading: ref.watch(
                                    isLoadingProvider("set_personal_id")),
                                magnifier: true,
                              ),
                              PositionedDirectional(
                                end: 10,
                                bottom: 10,
                                child: InkWell(
                                  onTap: () async {
                                    final imageFile =
                                        await newImageProvider.pickImage();
                                    if (imageFile != null) {
                                      try {
                                        ref
                                            .read(isLoadingProvider(
                                                    "set_personal_id")
                                                .notifier)
                                            .state = true;

                                        final uploaded = await newImageProvider
                                            .uploadFile(File(imageFile.path));
                                        form
                                            .control('personal_id_image')
                                            .value = uploaded;
                                      } finally {
                                        ref
                                            .read(isLoadingProvider(
                                                    "set_personal_id")
                                                .notifier)
                                            .state = false;
                                      }
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    child: const Icon(Icons.edit),
                                  ),
                                ),
                              ),
                              PositionedDirectional(
                                end: 60,
                                bottom: 10,
                                child: InkWell(
                                  onTap: () async {
                                    form.control('personal_id_image').value =
                                    null;
                                  },
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: AppColor.danger2,
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          )
                        : Consumer(
                            builder: (context, ref, _) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 32.r,
                                      backgroundColor:
                                          AppColor.grey1.withOpacity(.5),
                                      child: Icon(
                                          CupertinoIcons.cloud_upload_fill,
                                          color: Colors.black.withOpacity(.65)),
                                    ),
                                    Gap(10.h),
                                    Text("SVG, PNG, JPG or GIF. (max 3MB)".tr,
                                        style: AppFont.font13W600Grey1),
                                    Gap(10.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.primary.withOpacity(.3),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Browser Files".tr,
                                          style: AppFont.font14W600Primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ));
              });
            },
          ),
          Gap(50.h),
        ],
      ),
    );
  }
}
