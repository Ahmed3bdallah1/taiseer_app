/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsNavigationBarGen {
  const $AssetsNavigationBarGen();

  /// File path: assets/Navigation_bar/box.svg
  String get box => 'assets/Navigation_bar/box.svg';

  /// File path: assets/Navigation_bar/home-2.svg
  String get home2 => 'assets/Navigation_bar/home-2.svg';

  /// File path: assets/Navigation_bar/message-question.svg
  String get messageQuestion => 'assets/Navigation_bar/message-question.svg';

  /// File path: assets/Navigation_bar/profile-circle.svg
  String get profileCircle => 'assets/Navigation_bar/profile-circle.svg';

  /// List of all assets
  List<String> get values => [box, home2, messageQuestion, profileCircle];
}

class $AssetsBaseGen {
  const $AssetsBaseGen();

  /// File path: assets/base/Flag Kuwait.png
  AssetGenImage get flagKuwait =>
      const AssetGenImage('assets/base/Flag Kuwait.png');

  /// File path: assets/base/Frame 195.svg
  String get frame195 => 'assets/base/Frame 195.svg';

  /// File path: assets/base/background.jpeg
  AssetGenImage get background =>
      const AssetGenImage('assets/base/background.jpeg');

  /// File path: assets/base/calender.svg
  String get calender => 'assets/base/calender.svg';

  /// File path: assets/base/eye-crossed.svg
  String get eyeCrossed => 'assets/base/eye-crossed.svg';

  /// File path: assets/base/eye.svg
  String get eye => 'assets/base/eye.svg';

  /// File path: assets/base/file_background.jpeg
  AssetGenImage get fileBackground =>
      const AssetGenImage('assets/base/file_background.jpeg');

  /// File path: assets/base/finger-scan.svg
  String get fingerScan => 'assets/base/finger-scan.svg';

  /// File path: assets/base/loading.gif
  AssetGenImage get loading => const AssetGenImage('assets/base/loading.gif');

  /// File path: assets/base/loan_container.jpeg
  AssetGenImage get loanContainer =>
      const AssetGenImage('assets/base/loan_container.jpeg');

  /// File path: assets/base/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/base/logo.png');

  /// File path: assets/base/logo_with_text.svg
  String get logoWithText => 'assets/base/logo_with_text.svg';

  /// File path: assets/base/money.svg
  String get money => 'assets/base/money.svg';

  /// File path: assets/base/no_wifi.json
  String get noWifi => 'assets/base/no_wifi.json';

  /// File path: assets/base/personal.png
  AssetGenImage get personal => const AssetGenImage('assets/base/personal.png');

  /// File path: assets/base/rec.png
  AssetGenImage get rec => const AssetGenImage('assets/base/rec.png');

  /// File path: assets/base/search.svg
  String get search => 'assets/base/search.svg';

  /// File path: assets/base/tayseer_logo.png
  AssetGenImage get tayseerLogo =>
      const AssetGenImage('assets/base/tayseer_logo.png');

  /// File path: assets/base/whatsapp.svg
  String get whatsapp => 'assets/base/whatsapp.svg';

  /// List of all assets
  List<dynamic> get values => [
        flagKuwait,
        frame195,
        background,
        calender,
        eyeCrossed,
        eye,
        fileBackground,
        fingerScan,
        loading,
        loanContainer,
        logo,
        logoWithText,
        money,
        noWifi,
        personal,
        rec,
        search,
        tayseerLogo,
        whatsapp
      ];
}

class $AssetsOnboardGen {
  const $AssetsOnboardGen();

  /// File path: assets/onboard/Vector.svg
  String get vector => 'assets/onboard/Vector.svg';

  /// File path: assets/onboard/flag.png
  AssetGenImage get flag => const AssetGenImage('assets/onboard/flag.png');

  /// File path: assets/onboard/get_started.gif
  AssetGenImage get getStarted =>
      const AssetGenImage('assets/onboard/get_started.gif');

  /// File path: assets/onboard/kawuit.png
  AssetGenImage get kawuit => const AssetGenImage('assets/onboard/kawuit.png');

  /// File path: assets/onboard/onboard_1.gif
  AssetGenImage get onboard1 =>
      const AssetGenImage('assets/onboard/onboard_1.gif');

  /// File path: assets/onboard/onboard_2.gif
  AssetGenImage get onboard2 =>
      const AssetGenImage('assets/onboard/onboard_2.gif');

  /// File path: assets/onboard/onboard_3.gif
  AssetGenImage get onboard3 =>
      const AssetGenImage('assets/onboard/onboard_3.gif');

  /// File path: assets/onboard/usa.png
  AssetGenImage get usa => const AssetGenImage('assets/onboard/usa.png');

  /// List of all assets
  List<dynamic> get values =>
      [vector, flag, getStarted, kawuit, onboard1, onboard2, onboard3, usa];
}

class Assets {
  Assets._();

  static const $AssetsNavigationBarGen navigationBar =
      $AssetsNavigationBarGen();
  static const $AssetsBaseGen base = $AssetsBaseGen();
  static const $AssetsOnboardGen onboard = $AssetsOnboardGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
