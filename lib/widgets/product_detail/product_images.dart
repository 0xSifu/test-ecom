import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/product_detail/popup_image_carousel.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key, required this.productImages, this.carouselController, this.onPageChanged});

  /// product images
  final List productImages;
  final CarouselSliderController? carouselController;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  // int _imagePos = 0;

  void showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupImageCarousel(
          images: widget.productImages,
          showThumbnail: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: widget.carouselController,
          options: CarouselOptions(
            aspectRatio: 1,
            autoPlay: false,
            viewportFraction: 1.0,
            onPageChanged: widget.onPageChanged,
          ),
          items: [
            for (String productImage in widget.productImages)
              GestureDetector(
                onTap: () => showImagePopup(context),
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: const Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: UEImage2(
                    productImage,
                    fit: BoxFit.contain
                  ),
                  ),
                ),
              ),
          ],
        ),
        // Positioned(
        //   left: 15,
        //   bottom: 15,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 5,
        //       vertical: 2,
        //     ),
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: const Color(0xFFD3D3D3),
        //         style: BorderStyle.solid,
        //       ),
        //       borderRadius: BorderRadius.circular(5),
        //       color: Colors.white,
        //     ),
        //     child: Text(
        //       "${_imagePos + 1}/${widget.productImages.length}",
        //       style: const TextStyle(
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
