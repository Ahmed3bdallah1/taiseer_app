import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:taiseer/ui/shared_widgets/custom_slider.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:taiseer/ui/shared_widgets/select_language_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/search_shipments_text_field.dart';
import '../../../../user_features/search/presentation/managers/search_providers.dart';
import '../../../../user_features/user_company/presentation/view/widgets/company_container.dart';

enum SearchMethodTypes {
  phone,
  history,
  status,
}

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final AutoDisposeStateProvider<bool> hideNavBarProvider2;
  final FormGroup formGroup = FormGroup({
    'search': FormControl<String>(),
    'type': FormControl<int>(validators: [Validators.required]),
  });
  final _debouncer = CustomDelay(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideNavBarProvider2 = StateProvider.autoDispose<bool>((ref) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(fetchUserSearchProvider(
        formGroup.control('search') as FormControl));
    return Scaffold(
      body: ReactiveForm(
        formGroup: formGroup,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AnimatedSizeAndFade.showHide(
                show: !ref.watch(hideNavBarProvider2),
                child: CustomAppBar2(title: "Search".tr),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: CustomTextField<String?>(
                      formControlName: "search",
                      hintText: "Search".tr,
                      onChanged: (x) {
                        _debouncer.run(() {
                          formGroup.control("type").valid
                              ? ref.invalidate(fetchUserSearchProvider(
                                  formGroup.control('search') as FormControl))
                              : formGroup.markAllAsTouched();
                        });
                      },
                    ),
                  ),
                  Gap(10.w),
                  Expanded(
                      flex: 2,
                      child: CustomTextField<int>(
                        formControlName: "type",
                        hintText: "Type",
                        type: TextFieldType.selectable,
                        items: [
                          ...SearchMethodTypes.values
                              .map((e) => DropdownMenuItem(
                                    value: e.index,
                                    child: Text(e.name.tr),
                                  ))
                        ],
                        onChanged: (x) {
                          ref.read(sliderIndexProvider.notifier).state =
                              x.value ?? 0;
                        },
                      )),
                ],
              ),
              Gap(16.h),
              if (provider.value != null)
                const Divider(
                  thickness: 2,
                ),
              Gap(16.h),
              ReactiveFormConsumer(builder: (context, form, _) {
                return Consumer(
                  builder: (context, ref, _) {
                    return provider.customWhen(
                        ref: ref,
                        refreshable: fetchUserSearchProvider(
                                form.control('search') as FormControl)
                            .future,
                        data: (companies) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: companies.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox();
                                // return Padding(
                                //   padding: const EdgeInsets.only(bottom: 12),
                                //   child: CompanyContainer(
                                //     companyModel: companies.item1[index],
                                //   ),
                                // );
                              },
                            ),
                          );
                        },
                        loading: () {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[900]!,
                                    highlightColor: Colors.green[100]!,
                                    child: Container(
                                      height: 80.h,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        });
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
