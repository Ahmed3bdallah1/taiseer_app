import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning/config/api_path.dart';
import 'package:learning/gen/assets.gen.dart';
import 'package:learning/ui/shared_widgets/loading_widget.dart';
import 'package:photo_view/photo_view.dart';

import '../../config/app_color.dart';
import 'back_icon.dart';

class ImageOrSvg extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final bool magnifier;
  final bool isLocal;
  final bool isLoading;
  final bool isCircleLoading;
  final bool pickImageOnNull;

  ImageOrSvg(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.magnifier = false,
    this.color,
    this.isLoading = false,
    this.isLocal = false,
    this.isCircleLoading = true,
    this.pickImageOnNull = false,
  }) : super(key: ValueKey(url));

  @override
  State<ImageOrSvg> createState() => _ImageOrSvgState();
}

class _ImageOrSvgState extends State<ImageOrSvg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    if (widget.isLoading) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: AppColor.grey_3,
            shape:
                widget.isCircleLoading ? BoxShape.circle : BoxShape.rectangle),
        child: const Center(child: LoadingWidget()),
      );
    } else if (widget.pickImageOnNull) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: AppColor.grey_3,
            shape:
                widget.isCircleLoading ? BoxShape.circle : BoxShape.rectangle),
        child: const Center(
            child: Icon(
          Icons.add_photo_alternate_outlined,
          color: AppColor.primary,
          size: 50,
        )),
      );
    }
    final fullPath = widget.isLocal
        ? widget.url
        : widget.url!.startsWith("http")
            ? widget.url
            : "${ApiPath.uploadPath}${widget.url}";
    return fullPath!.endsWith(".svg")
        ? widget.isLocal
            ? SvgPicture.asset(
                fullPath,
                key: widget.key,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
                color: widget.color,
              )
            : SvgPicture.network(
                key: widget.key,
                fullPath,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
                color: widget.color,
              )
        : widget.isLocal
            ? ExtendedImage.asset(
                fullPath,
                key: widget.key,
                width: widget.width,
                color: widget.color,
                height: widget.height,
                fit: widget.fit,
                opacity: _controller,
                enableLoadState: true,
                loadStateChanged: _handleLoadStateChange,
              )
            : ExtendedImage.network(
                fullPath,
                key: widget.key,
                width: widget.width,
                color: widget.color,
                height: widget.height,
                fit: widget.fit,
                cache: true,
                opacity: _controller,
                handleLoadingProgress: true,
                enableLoadState: true,
                cacheMaxAge: const Duration(days: 7),
                loadStateChanged: _handleLoadStateChange,
              );
  }

  Widget _handleLoadStateChange(ExtendedImageState ff) {
    switch (ff.extendedImageLoadState) {
      case LoadState.loading:
        _controller.reset();
        return Image.asset(
          Assets.base.loading.path,
          fit: BoxFit.fill,
        );
      case LoadState.failed:
        _controller.forward();
        return FadeTransition(
          opacity: _controller,
          child: InkWell(
            onTap: () {
              ff.reLoadImage();
            },
            child: const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        );
      case LoadState.completed:
        _controller.forward();
        return FadeTransition(
          opacity: _controller,
          child: InkWell(
            onTap: !widget.magnifier
                ? null
                : () {
                    if (ff.extendedImageInfo != null) {
                      Get.to(() => _ImageMagnifier(
                            image: ff.extendedImageInfo!,
                          ));
                    }
                  },
            child: ExtendedRawImage(
              image: ff.extendedImageInfo?.image,
              width: widget.width,
              color: widget.color,
              height: widget.height,
              fit: widget.fit,
            ),
          ),
        );
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ImageMagnifier extends StatelessWidget {
  const _ImageMagnifier({required this.image});

  final ImageInfo image;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackIcon(),
      body: PhotoView.customChild(
        child: ExtendedRawImage(
          image: image.image,
        ),
      ),
    );
  }
}
