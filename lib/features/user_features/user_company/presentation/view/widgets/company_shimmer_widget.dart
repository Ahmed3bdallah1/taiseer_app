import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CompanyShimmerWidget extends StatelessWidget {
  const CompanyShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[900]!,
        highlightColor: Colors.green[100]!,
        child: Container(
          height: 100,
          width: MediaQuery.of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Colors.grey
                .withOpacity(.15),
            borderRadius:
            BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}