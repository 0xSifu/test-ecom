
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UEImage extends StatefulWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Color? color;
  final Color? backgroundColor;
  final double? cornerRadius;
  final Animation<double>? opacity;
  final bool showShimmer;

  const UEImage(this.src, {
    super.key,
    double scale = 1.0,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.opacity,
    this.fit,
    this.cornerRadius,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.showShimmer = true
  });

  @override
  State<UEImage> createState() => _UEImageState();
}

class _UEImageState extends State<UEImage> {
  late final Image image = Image(
    image: CachedNetworkImageProvider(widget.src, errorListener: (error) {

    }),
    width: widget.width,
    height: widget.height,
    fit: widget.fit,
    alignment: widget.alignment,
    repeat: widget.repeat,
    color: widget.color,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      if (widget.showShimmer == false) return child;
      return Shimmer.fromColors(
        baseColor: Colors.grey[300] ?? Colors.grey,
        highlightColor: Colors.grey[100] ?? Colors.grey,
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white)),
      );
    },
    errorBuilder: (context, object, stackTrace) => Center(child: Icon(Icons.broken_image, size: widget.width))
  );
  //  UEImage2(
  //       widget.src,
  //       width: widget.width,
  //       height: widget.height,
  //       fit: widget.fit,
  //       alignment: widget.alignment,
  //       repeat: widget.repeat,
  //       color: widget.color,
  //       loadingBuilder: (context, child, loadingProgress) {
  //         if (loadingProgress == null) return child;
  //         return Shimmer.fromColors(
  //           baseColor: Colors.grey[300] ?? Colors.grey,
  //           highlightColor: Colors.grey[100] ?? Colors.grey,
  //           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white)),
  //         );
  //       },
  //       errorBuilder: (context, object, stackTrace) => CachedNetworkImage(
  //         imageUrl: Thumbnail.defaultUrl,
  //         width: widget.width,
  //         height: widget.height,
  //         fit: widget.fit,
  //         alignment: widget.alignment,
  //         repeat: widget.repeat,
  //         color: widget.color,
  //         progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
  //           baseColor: Colors.grey[300] ?? Colors.grey,
  //           highlightColor: Colors.grey[100] ?? Colors.grey,
  //           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white)),
  //         )
  //       )
  //     );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(image.image, context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.cornerRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.cornerRadius!),
        child: Container(
          color: widget.backgroundColor,
          child: image,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.cornerRadius != null ? BorderRadius.circular(widget.cornerRadius!) : null
      ),
      child: image,
    );
  }
}

class UEImage2 extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Color? color;
  final Color? backgroundColor;
  final Animation<double>? opacity;
  final bool showShimmer;
  final Function? onFinishedProgress;

  const UEImage2(this.src, {
    super.key,
    double scale = 1.0,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.opacity,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.showShimmer = true,
    this.onFinishedProgress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CachedNetworkImage(
        imageUrl: src,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        color: color,
        useOldImageOnUrlChange: true,
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider, 
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            color: color,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded == true) {
              Future.delayed(const Duration(milliseconds: 100), () {
                onFinishedProgress?.call();
              });
            }
            return child;
          });
        },
        progressIndicatorBuilder: (context, url, progress) {
          return showShimmer == false ? Container() : Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? Colors.grey,
            highlightColor: Colors.grey[100] ?? Colors.grey,
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white)),
          );
        },
        errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image, size: width)),
      ),
    );
  }
}