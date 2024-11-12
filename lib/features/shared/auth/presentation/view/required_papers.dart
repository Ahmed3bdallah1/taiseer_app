import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/shared/auth/presentation/view/create_password.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../config/app_font.dart';
import '../../../../../core/service/image_picker_cropper.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';

class RequiredPapersRegister extends StatefulWidget {
  const RequiredPapersRegister({super.key});

  @override
  State<RequiredPapersRegister> createState() => _RequiredPapersRegisterState();
}

class _RequiredPapersRegisterState extends State<RequiredPapersRegister> {
  final formGroup = FormGroup({
    'front_id': FormControl<File>(),
    'back_id': FormControl<File>(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        customTitleWidget: SvgPicture.asset(Assets.base.logo.path),
      ),
      body: ReactiveForm(
        formGroup: formGroup,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16.h),
                Text("additional info".tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Gap(8.h),
                Text(
                    "Verification completed successfully, complete the following information data"
                        .tr,
                    style: AppFont.font13W600Grey2),
                Gap(16.h),
                LinearProgressIndicator(
                  minHeight: 10.h,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  value: 0.7,
                  color: AppColor.primary,
                  backgroundColor: Colors.white,
                ),
                Gap(16.h),
                Text("front id photo".tr, style: AppFont.labelTextField),
                Gap(10.h),
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final image = form.control("front_id").value;
                    return image != null
                        ? SizedBox(height: 200, child: Image.file(image))
                        : InkWell(
                            onTap: () async {
                              final file = await getIt
                                  .call<ImagePickerService>()
                                  .pickImage();
                              form.control("front_id").updateValue(file);
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.16),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.cloud_upload_fill,
                                          color: Colors.black.withOpacity(.65)),
                                      const Gap(5),
                                      Text(
                                        "please upload the required files".tr,
                                        style: AppFont.labelTextField.copyWith(
                                            color:
                                                Colors.black.withOpacity(.65)),
                                      ),
                                      const Gap(10),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Text(
                                      "download_info".tr,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: AppFont.subLabelTextField.copyWith(
                                          color: Colors.black.withOpacity(.65)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
                Gap(10.h),
                Text("back id photo".tr, style: AppFont.labelTextField),
                Gap(10.h),
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final image = form.control("back_id").value;
                    return image != null
                        ? SizedBox(height: 200, child: Image.file(image))
                        : InkWell(
                            onTap: () async {
                              final file = await getIt
                                  .call<ImagePickerService>()
                                  .pickImage();
                              form.control("back_id").updateValue(file);
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.16),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.cloud_upload_fill,
                                          color: Colors.black.withOpacity(.65)),
                                      const Gap(5),
                                      Text(
                                        "please upload the required files".tr,
                                        style: AppFont.labelTextField.copyWith(
                                            color:
                                                Colors.black.withOpacity(.65)),
                                      ),
                                      const Gap(10),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Text(
                                      "download_info".tr,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: AppFont.subLabelTextField.copyWith(
                                          color: Colors.black.withOpacity(.65)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
                Gap(20.h),
                CustomFilledButton(
                  onPressed: () => Get.to(const CreatePassword()),
                  text: 'next'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
