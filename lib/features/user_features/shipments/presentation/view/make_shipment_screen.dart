import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/core/service/loading_provider.dart';
import 'package:taiseer/features/shared/auth/presentation/manager/auth_provuder.dart';
import 'package:taiseer/features/user_features/root/view/root_view.dart';
import 'package:taiseer/features/user_features/shipments/domain/use_cases/shipment_use_cases.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/ui.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../user_company/data/model/company_model.dart';
import 'shipment_view_widgets/shipment_title_widget.dart';
import 'shipment_view_widgets/shipment_to_from_widgets.dart';
import 'shipment_view_widgets/shipment_types_image_widget.dart';

class MakeShipmentScreen extends ConsumerStatefulWidget {
  final CompanyDetailsModel companyDetailsModel;
  final UserCompanyModel2 companyModel;
  final bool isGlobal;
  final bool viewOnly;

  const MakeShipmentScreen({
    super.key,
    required this.companyDetailsModel,
    required this.companyModel,
    this.isGlobal = false,
    this.viewOnly = false,
  });

  @override
  ConsumerState<MakeShipmentScreen> createState() => _MakeShipmentScreenState();
}

class _MakeShipmentScreenState extends ConsumerState<MakeShipmentScreen> {
  late final FormGroup formGroup;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    formGroup = FormGroup({
      'company_id': FormControl(
        value: widget.isGlobal ? 0 : widget.companyDetailsModel.id,
      ),
      'typeActivity_id': FormControl<List<int>?>(
          validators: [Validators.required],
          value: widget.isGlobal ? [1] : null),
      'is_fast_shipping':
          FormControl<bool>(validators: [Validators.required], value: false),
      'shipment_type': FormControl<String>(
          validators: [Validators.required], value: "general"),
      "content_description": FormControl(validators: [Validators.required]),
      'expected_delivery_date': FormControl(validators: [Validators.required]),
      'amount': FormControl<String>(validators: [Validators.required]),
      'payment_method':
          FormControl<String>(validators: [Validators.required], value: "cash"),
      'from_area': FormControl<String>(validators: [Validators.required]),
      'from_city_id': FormControl<int>(validators: [Validators.required]),
      'from_country_id': FormControl<int>(validators: [Validators.required]),
      'from_latitude': FormControl<double>(
          validators: [Validators.required], value: 40.712776),
      'from_longitude': FormControl<double>(
          validators: [Validators.required], value: -74.005974),
      'from_address_line':
          FormControl<String>(validators: [Validators.required]),
      // دى متستقبلهاش
      'sender_number_country': FormControl<int>(),
      'sender_number': FormControl<String>(validators: [Validators.required]),
      'to_address_line': FormControl<String>(validators: [Validators.required]),
      'to_country_id': FormControl<int>(validators: [Validators.required]),
      'to_city_id': FormControl<int>(validators: [Validators.required]),
      'to_area': FormControl<String>(validators: [Validators.required]),
      'to_latitude': FormControl<double>(
          validators: [Validators.required], value: 40.712776),
      'to_longitude': FormControl<double>(
          validators: [Validators.required], value: -74.005974),
      'receiver_name': FormControl<String>(validators: [Validators.required]),
      // دى متستقبلهاش
      'receiver_phone_country': FormControl<int>(),
      'receiver_phone': FormControl<String>(validators: [Validators.required]),

      'shipping_images': FormControl<List<String>>(validators: []),
    });

    formGroup.control('sender_number').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((controls) {
          final res = formGroup.control('sender_number_country').value is int;
          if (res) {
            return null;
          } else {
            return {'please select country'.tr: 'please select country'};
          }
        })
      ])
    ]);

    formGroup.control('receiver_phone').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((control) {
          final res = formGroup.control('receiver_phone_country').value is int;
          if (res) {
            return null;
          } else {
            return {'please select country'.tr: 'sdfdsfds'};
          }
        })
      ])
    ]);

    // formGroup.control('index').valueChanges.listen((event) {
    //   controller.jumpToPage(event);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final country = ref.watch(fetchCountryProvider).value;
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: CustomLogoAppbar(
        scrollController: scrollController,
        hideActions: true,
        customTitleWidget: Text(
          "apply".tr,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 60),
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: formGroup,
            child: Column(
              children: [
                ShipmentHeaderWidget(
                    isGlobal: widget.isGlobal,
                    companyModel: widget.companyModel),
                ShipmentTypeAndImagesWidget(
                    companyModel: widget.companyModel,
                    companyDetailsModel: widget.companyDetailsModel),
                ShipmentFromWidget(country: country),
                ShipmentToWidget(country: country)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReactiveForm(
          formGroup: formGroup,
          child: ReactiveFormConsumer(
            builder: (BuildContext context, FormGroup form, Widget? child) {
              final isValid = form.valid;
              return CustomFilledButton(
                text: "next".tr,
                onPressed: () async {
                  if (form.valid) {
                    try {
                      ref.read(isLoadingProvider("submit").notifier).state =
                          true;
                      final res = await getIt<SubmitShipmentUseCase>().call(
                        {...form.value}
                          ..removeWhere((key, value) => value == null),
                      );
                      res.fold((l) {
                        UIHelper.showAlert(l.message, type: DialogType.error);
                      }, (r) async {
                        await UIHelper.showAlert(
                            "Shipment submitted successfully".tr);
                        Get.offAll(() => const RootView());
                      });
                    } finally {
                      ref.read(isLoadingProvider("submit").notifier).state =
                          false;
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                isValid: isValid,
                isLoading: ref.watch(isLoadingProvider("submit")),
              );
            },
          ),
        ),
      ),
    );
  }
}
