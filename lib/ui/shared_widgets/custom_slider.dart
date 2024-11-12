import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

final sliderIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});


class CustomSlider extends ConsumerWidget {
  const CustomSlider(this.sliders,{this.height, this.autoPlay, this.onPageChanged, super.key});
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final bool? autoPlay;
  final List<dynamic>? sliders;
  final double? height;

  @override
  Widget build(BuildContext context, ref) {
    final current = ref.watch(sliderIndexProvider);
    if (sliders?.isEmpty ?? true) {
      return const SizedBox();
    }
    responsiveInit(context);
    final isOneImage = sliders?.length == 1;
    return ClipRRect(
      borderRadius:
          height == null ? BorderRadius.zero : BorderRadius.circular(10),
      child: Stack(
        children: [CarouselSlider(
            items: sliders?.first is Widget
                ? sliders!.map((i) {
                    return i as Widget;
                  }).toList()
                : sliders!.map((i) {
                    return ImageOrSvg(
                      i.image!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    );
                  }).toList(),
            options: CarouselOptions(
              onPageChanged: onPageChanged,
              viewportFraction: 1,
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 5),
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: autoPlay ?? true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollPhysics: isOneImage
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            )),
          if (!isOneImage)
            Positioned(
              bottom: 10.0.h,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Transform.flip(
                 flipX: true,
                  child: CarouselIndicator(
                    count: sliders!.length,
                    color: AppColor.grey1,
                    activeColor: AppColor.primary,
                    index: current,
                  ),
                ),
              ),
            ),
        ]
      ),
    );
  }
}
