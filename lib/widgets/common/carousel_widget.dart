import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/models/carousel_model.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:sizer/sizer.dart' as sizer;

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
    this.boxFit = BoxFit.contain,
    this.autoPlay = false,
    required this.list,
  });

  /// box fit
  final BoxFit boxFit;

  /// auto play the carousel
  /// default: false
  final bool autoPlay;

  /// carousel list
  final List<CarouselModel> list;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: widget.autoPlay,
            aspectRatio: sizer.Device.screenType == sizer.ScreenType.tablet ? 2064/663 : 1179/600,
            viewportFraction: 1.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.list.map((image) {
            return InkWell(
              onTap: () => image.url != '' ? Get.toNamed(image.url) : false,
              child: UEImage2(
                image.image,
                fit: widget.boxFit,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.list.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 20 : 10,
                  height: 10,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
