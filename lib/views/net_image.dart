import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/gen/assets.gen.dart';

class ImageChecker extends StatelessWidget {
  const ImageChecker({
    Key? key,
    required this.linkImage,
    this.tempImageUrl,
    this.errorImage,
    this.fit,
    this.width,
    this.memCacheHeight,
    this.backGroundColor,
    this.color,
    this.fitTemp,
    this.memCacheWidth,
    this.padding = 0,
    this.radius = 0,
    this.height,
  }) : super(key: key);
  final String? linkImage;
  final double? padding;
  final String? tempImageUrl;
  final Color? backGroundColor;
  final Color? color;
  final BoxFit? fit;
  final BoxFit? fitTemp;
  final String? errorImage;
  final double? width, height;
  final int? memCacheWidth, memCacheHeight;
  final double radius;

  @override
  Widget build(BuildContext context) {
    CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
    // logger("linkImage $linkImage");
    final tempImage = Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: Image.asset(
        tempImageUrl ?? Assets.images.logo.path,
        fit: fitTemp,
        width: width,
        color: color,
        height: height,
      ),
    );
    return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: checkIsNull(linkImage)
            ? tempImage
            : linkImage?.contains("http") == true
                ? CachedNetworkImage(
                    memCacheHeight: memCacheHeight,
                    fadeInDuration: const Duration(milliseconds: 1),
                    fadeOutDuration: const Duration(milliseconds: 1),
                    fadeInCurve: Curves.ease,
                    color: color,
                    fadeOutCurve: Curves.ease,
                    placeholderFadeInDuration: const Duration(milliseconds: 1),
                    memCacheWidth: memCacheWidth,
                    imageUrl: linkImage!,
                    progressIndicatorBuilder: (context, url, progress) {
                      logger(
                          "progress  ${progress.progress} -  ${progress.downloaded}   ${progress.totalSize}");
                      return ColoredBox(
                        color: backGroundColor ?? Colors.grey.withOpacity(0.3),
                        child: Center(
                            child: CircularProgressIndicator(
                                value: progress.progress,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor))),
                      );
                    },
                    errorWidget: (context, url, error) => tempImage,
                    fit: fit,
                    width: width,
                    height: height)
                : tempImage);
  }
}
