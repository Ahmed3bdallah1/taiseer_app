import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/history_container.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_model.dart';
import 'package:taiseer/features/user_features/user_company/domain/entity/comment_entity.dart';
import 'package:taiseer/ui/shared_widgets/custom_logo_app_bar.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../ui/shared_widgets/search_shipments_text_field.dart';
import '../../../user_company/presentation/view/widgets/comment_container.dart';
import '../../../user_company/presentation/view/widgets/company_container.dart';
import '../managers/search_providers.dart';

class SearchUserView extends ConsumerStatefulWidget {
  const SearchUserView({super.key});

  @override
  ConsumerState<SearchUserView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchUserView> {
  final FormGroup formGroup = FormGroup({'name': FormControl<String>()});
  final _debouncer = CustomDelay(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(
      fetchUserSearchProvider(formGroup.control("name") as FormControl),
    );
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: CustomLogoAppbar(
        customTitleWidget: Text('Search'.tr),
        hideBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            children: [
              CustomTextField<String?>(
                formControlName: "name",
                hintText: "Search".tr,
                onChanged: (x) {
                  _debouncer.run(() {
                    ref.invalidate(fetchUserSearchProvider(
                        formGroup.control('name') as FormControl));
                  });
                },
              ),
              Gap(16.h),
              ReactiveFormConsumer(builder: (context, form, _) {
                return Consumer(
                  builder: (context, ref, _) {
                    return provider.customWhen(
                        ref: ref,
                        refreshable: fetchUserSearchProvider(
                                form.control('name') as FormControl)
                            .future,
                        data: (companies) {
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...companies.map((e) {
                                    if (e is UserCompanyModel2) {
                                      return CompanyContainer(companyModel: e);
                                    } else if (e is CommentsEntity) {
                                      return CommentContainer(
                                          commentsEntity: e);
                                    } else if(e is ShipmentModel){
                                      return ShipmentContainer(shipment: e);
                                    } else{
                                      return const SizedBox.shrink();
                                    }
                                  })
                                ],
                              ),
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
