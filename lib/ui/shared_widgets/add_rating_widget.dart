import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/cupertino.dart';
import '../../config/app_font.dart';

class AddRatingWidget extends StatefulWidget {
  final double initRate;
  final String title;
  final Widget? widget;
  final void Function(double rating) onChanged;

  const AddRatingWidget({
    super.key,
    required this.initRate,
    required this.onChanged,
    required this.title,
    this.widget,
  });

  @override
  State<AddRatingWidget> createState() => _AddRatingIndexState();
}

class _AddRatingIndexState extends State<AddRatingWidget> {
  double currentIndex = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              widget.title,
              style: AppFont.font15W700Black),
          Row(
            children: [
              widget.widget ?? const SizedBox(),
              const SizedBox(width: 5),
              AnimatedRatingStars(
                initialRating:widget.initRate,
                minRating: 0.0,
                maxRating: 5.0,
                onChanged: widget.onChanged,
                displayRatingValue: true,
                interactiveTooltips: true,
                starSize: 18,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.bounceIn,
                readOnly: false, customFilledIcon: CupertinoIcons.star_fill, customHalfFilledIcon: CupertinoIcons.star_fill, customEmptyIcon: CupertinoIcons.star,
              ),
            ],
          ),
        ],
      ),
    );
  }
}