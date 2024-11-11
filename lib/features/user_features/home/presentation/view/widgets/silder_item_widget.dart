import 'package:flutter/material.dart';
import 'package:learning/config/app_color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../domain/entities/ad_entity.dart';

class SliderItem extends StatelessWidget {
  const SliderItem(
    this.item, {
    super.key,
  });

  final AdEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: ImageOrSvg(
            item.photo,
            fit: BoxFit.fill,
            isLocal: true,
          ),
        ),
      ),
    );
  }
}

class SliderShimmerItem extends StatelessWidget {
  const SliderShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
      ),
    );
  }
}
