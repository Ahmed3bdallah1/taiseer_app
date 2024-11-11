import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_color.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/image_picker_cropper.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../main.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../user_features/profile/presentation/manager/upload_file_notifier.dart';

class CompanyImagesInfo extends StatefulWidget {
  final ScrollController scrollController;

  const CompanyImagesInfo({super.key, required this.scrollController});

  @override
  State<CompanyImagesInfo> createState() => _CompanyImagesInfoState();
}

class _CompanyImagesInfoState extends State<CompanyImagesInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Company logo".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final image = form.control("company_logo_image").value as String?;
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
                              .read(isLoadingProvider("set_company_logo")
                                  .notifier)
                              .state = true;

                          final uploaded = await newImageProvider
                              .uploadFile(File(imageFile.path));
                          form.control('company_logo_image').value = uploaded;
                        } finally {
                          ref
                              .read(isLoadingProvider("set_company_logo")
                                  .notifier)
                              .state = false;
                        }
                      }
                    },
                    child: image != null ||
                            ref.watch(isLoadingProvider("set_company_logo"))
                        ? Stack(
                            children: [
                              ImageOrSvg(
                                image ?? "/assets/img/default.png",
                                fit: BoxFit.fitHeight,
                                height: 200,
                                isCircleLoading: false,
                                width: double.infinity,
                                isLoading: ref.watch(
                                    isLoadingProvider("set_company_logo")),
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
                                                    "set_company_logo")
                                                .notifier)
                                            .state = true;

                                        final uploaded = await newImageProvider
                                            .uploadFile(File(imageFile.path));
                                        form
                                            .control('company_logo_image')
                                            .value = uploaded;
                                      } finally {
                                        ref
                                            .read(isLoadingProvider(
                                                    "set_company_logo")
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
                                    form.control('company_logo_image').value =
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
          Gap(16.h),
          Text("Company cover".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final image =
                  form.control("company_cover_image").value as String?;
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
                              .read(isLoadingProvider("set_company_cover")
                                  .notifier)
                              .state = true;

                          final uploaded = await newImageProvider
                              .uploadFile(File(imageFile.path));
                          form.control('company_cover_image').value = uploaded;
                        } finally {
                          ref
                              .read(isLoadingProvider("set_company_cover")
                                  .notifier)
                              .state = false;
                        }
                      }
                    },
                    child: image != null ||
                            ref.watch(isLoadingProvider("set_company_cover"))
                        ? Stack(
                            children: [
                              ImageOrSvg(
                                image ?? "/assets/img/default.png",
                                fit: BoxFit.fitHeight,
                                height: 200,
                                isCircleLoading: false,
                                width: double.infinity,
                                isLoading: ref.watch(
                                    isLoadingProvider("set_company_cover")),
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
                                                    "set_company_cover")
                                                .notifier)
                                            .state = true;

                                        final uploaded = await newImageProvider
                                            .uploadFile(File(imageFile.path));
                                        form
                                            .control('company_cover_image')
                                            .value = uploaded;
                                      } finally {
                                        ref
                                            .read(isLoadingProvider(
                                                    "set_company_cover")
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
                                    form.control('company_cover_image').value =
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
          Gap(16.h),
          Text("Official license image".tr),
          Gap(10.h),
          ReactiveFormConsumer(
            builder: (context, form, _) {
              final image =
                  form.control("official_license_image").value as String?;
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
                              .read(isLoadingProvider("set_license").notifier)
                              .state = true;

                          final uploaded = await newImageProvider
                              .uploadFile(File(imageFile.path));
                          form.control('official_license_image').value =
                              uploaded;
                        } finally {
                          ref
                              .read(isLoadingProvider("set_license").notifier)
                              .state = false;
                        }
                      }
                    },
                    child: image != null ||
                            ref.watch(isLoadingProvider("set_license"))
                        ? Stack(
                            children: [
                              ImageOrSvg(
                                image ?? "/assets/img/default.png",
                                fit: BoxFit.fitHeight,
                                height: 200,
                                isCircleLoading: false,
                                width: double.infinity,
                                isLoading:
                                    ref.watch(isLoadingProvider("set_license")),
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
                                            .read(
                                                isLoadingProvider("set_license")
                                                    .notifier)
                                            .state = true;

                                        final uploaded = await newImageProvider
                                            .uploadFile(File(imageFile.path));
                                        form
                                            .control('official_license_image')
                                            .value = uploaded;
                                      } finally {
                                        ref
                                            .read(
                                                isLoadingProvider("set_license")
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
                                    form.control('official_license_image').value =
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
