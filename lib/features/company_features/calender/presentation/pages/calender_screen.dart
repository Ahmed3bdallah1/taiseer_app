import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_color.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/core/service/localization_service/localization_service.dart';
import 'package:learning/features/company_features/calender/presentation/widgets/calender_header.dart';
import 'package:learning/ui/shared_widgets/hide_nav_bar_widget.dart';
import 'package:learning/ui/shared_widgets/not_found_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../track_orders/presentation/view/order_dialog_widget.dart';
import '../../domain/entities/calender_day_entity.dart';
import '../manager/calender_state_providers.dart';
import '../manager/get_calender_provider.dart';

class CalenderScreen extends ConsumerStatefulWidget {
  const CalenderScreen({super.key});

  @override
  ConsumerState<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalenderScreen>
    with TickerProviderStateMixin {
  final DateTime _currentDate = DateTime.now();
  late final TabController controller;
  late final AutoDisposeStateProvider<bool> hideNavBarProvider2;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        ref.read(selectedCalenderIndexProvider.notifier).state =
            controller.index;
      });
    hideNavBarProvider2 = StateProvider.autoDispose<bool>((ref) {
      return false;
    });
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return (date1.year == date2.year) && (date1.month == date2.month);
  }

  bool isLast(DateTime date, DateTime lastDate) {
    return date.isBefore(lastDate) || isSameDay(date, lastDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedSizeAndFade.showHide(
              show: !ref.watch(hideNavBarProvider2),
              child: SizedBox(
                height: 60,
                child: TabBar(
                  controller: controller,
                  onTap: (index) {
                    ref.read(selectedCalenderIndexProvider.notifier).state =
                        index;
                  },
                  tabs: [
                    Tab(
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            'Pre order'.tr,
                            style: AppFont.font16W700Black,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            'History'.tr,
                            style: AppFont.font16W700Black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: HideNavBarWidget(
                customProvider: hideNavBarProvider2,
                child: Consumer(builder: (context, ref, child) {
                  final ordersHistory =
                      ref.watch(fetchCompanyCalenderHistoryProvider);
                  DateTime date = ref.watch(dateTimeProvider);
                  return ordersHistory.customWhen(
                      data: (data) {
                        if (data.isEmpty) {
                          return NotFoundWidget(
                              title: "No Installment right now.!".tr);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView(
                            children: [
                              Gap(10.h),
                              Column(
                                children: [
                                  CalendarHeader(
                                    focusedDay: date,
                                    clearButtonVisible: false,
                                    onTodayButtonTap: () {
                                      ref.read(dateTimeProvider.notifier).state =
                                          DateTime.now();
                                    },
                                    onClearButtonTap: () {},
                                    onLeftArrowTap: () {
                                      if (!isSameMonth(date, _currentDate)) {
                                        ref
                                            .read(dateTimeProvider.notifier)
                                            .state = DateTime(
                                          date.year,
                                          date.month - 1,
                                          date.day,
                                        );
                                      }
                                    },
                                    onRightArrowTap: () {
                                      final lastDate =
                                          DateTime.parse(data.last.date);
                                      if (isLast(date, lastDate)) {
                                        final nextMonth = DateTime(
                                          date.year,
                                          date.month + 1,
                                          date.day,
                                        );
                                        if (nextMonth.isBefore(lastDate) ||
                                            isSameDay(nextMonth, lastDate)) {
                                          ref
                                              .read(dateTimeProvider.notifier)
                                              .state = nextMonth;
                                        }
                                      }
                                    },
                                  ),
                                  AnimatedSizeAndFade.showHide(
                                    show: !ref.watch(hideNavBarProvider2),
                                    child: TableCalendar(
                                      locale: localeService
                                          .getLocale()
                                          .locale
                                          .languageCode,
                                      calendarFormat: CalendarFormat.month,
                                      firstDay: DateTime.now(),
                                      lastDay: DateTime.parse(data.last.date),
                                      focusedDay: date ?? DateTime.now(),
                                      currentDay: DateTime.now(),
                                      headerVisible: false,
                                      headerStyle: const HeaderStyle(
                                          formatButtonVisible: false,
                                          titleCentered: true),
                                      eventLoader: (date) {
                                        final events = data
                                            .firstWhereOrNull((element) =>
                                                intl.DateFormat.yMd('en').format(
                                                    DateTime.parse(element.date)) ==
                                                intl.DateFormat.yMd('en')
                                                    .format(date))
                                            ?.installment;
                                        if (events == null) {
                                          return [];
                                        } else {
                                          return events.map((e) => e).toList();
                                        }
                                      },
                                      onDaySelected: (dsf, aa) {
                                        final eventsData = data.firstWhereOrNull(
                                            (element) =>
                                                intl.DateFormat.yMd('en').format(
                                                    DateTime.parse(element.date)) ==
                                                intl.DateFormat.yMd('en')
                                                    .format(dsf));
                                        ref
                                            .read(eventsDataProvider.notifier)
                                            .state = eventsData;
                                      },
                                      calendarStyle: CalendarStyle(
                                          outsideDaysVisible: false,
                                          isTodayHighlighted: true,
                                          markerDecoration: BoxDecoration(
                                            color: AppColor.danger,
                                            shape: BoxShape.circle,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Consumer(builder: (context, ref, _) {
                                if (ref.watch(eventsDataProvider) != null) {
                                  return Column(
                                    children: [
                                      const Divider(thickness: 2),
                                      InstallmentDetails(
                                          ref.watch(eventsDataProvider)!),
                                    ],
                                  );
                                } else {
                                  return SizedBox(
                                      height: 250.h,
                                      width: double.infinity,
                                      child: Center(
                                        child: NotFoundWidget(
                                            title:
                                                "There is no history to show".tr),
                                      ));
                                }
                              })
                            ],
                          ),
                        );
                      },
                      ref: ref,
                      refreshable: fetchCompanyCalenderHistoryProvider.future);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstallmentDetails extends StatelessWidget {
  const InstallmentDetails(this.installmentDayEntity, {super.key});

  final CalenderDayEntity installmentDayEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: installmentDayEntity.installment.length,
            itemBuilder: (context, index) {
              final item = installmentDayEntity.installment[index];
              final num totalAmount = item.value!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showOrderDialog(context);
                  },
                  child: ListTile(
                    tileColor: item.status == 0
                        ? AppColor.danger.withOpacity(0.2)
                        : AppColor.green.withOpacity(0.2),
                    trailing: Text(item.status == 0 ? "not_paid".tr : "paid".tr),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    leading: const Icon(Icons.payment),
                    title: Row(
                      children: [
                        Text("order number".tr),
                        Text(" #${item.orderId.toString()}")
                      ],
                    ),
                    subtitle: Text("${totalAmount.toStringAsFixed(2)} ${"KWD".tr}"),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

// class InstallmentProgramDetails extends StatelessWidget {
//   const InstallmentProgramDetails(this.orderEntity, {super.key});
//
//   final OrderEntity orderEntity;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "${"order number".tr}  #${orderEntity.id.toString()}",
//       ),
//       body: Consumer(builder: (context, ref, child) {
//         final orderDates = ref.watch(getDatesForOrderProvider(orderEntity.id));
//         return orderDates.customWhen(
//             ref: ref,
//             refreshable: getDatesForOrderProvider(orderEntity.id).future,
//             data: (data) {
//               return ListView(
//                 children: [
//                   ...data.map((e) {
//                     final num totalAmount = e.value!;
//                     return FadeInAnimation(
//                       fadeOffset: 30,
//                       delay: 2.5,
//                       direction: FadeInDirection.leftToRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           trailing:
//                               Text(e.status == 0 ? "not_paid".tr : "paid".tr),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           tileColor: e.status == 0
//                               ? AppColor.danger.withOpacity(0.2)
//                               : AppColor.green.withOpacity(0.2),
//                           leading: const Icon(Icons.payment),
//                           subtitle: Text(e.piadDate!),
//                           title: Text(
//                               "${totalAmount.toStringAsFixed(2)} ${"KWD".tr}"),
//                         ),
//                       ),
//                     );
//                   })
//                 ],
//               );
//             });
//       }),
//     );
//   }
// }
