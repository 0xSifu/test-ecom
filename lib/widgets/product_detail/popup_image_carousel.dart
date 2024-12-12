import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class PopupImageCarousel extends StatefulWidget {
  const PopupImageCarousel({
    super.key,
    required this.images,
    this.showThumbnail = false,
  });

  /// list of image
  final List images;

  /// show thumbnail
  final bool? showThumbnail;

  @override
  State<PopupImageCarousel> createState() => _PopupImageCarouselState();
}

class _PopupImageCarouselState extends State<PopupImageCarousel> {
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  // image position
  int _imagePos = 0;

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: screenHeight * 0.6,
              autoPlay: false,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _imagePos = index;
                });
              },
            ),
            items: [
              for (int i = 0; i < widget.images.length; i++)
                InteractiveViewer(
                  child: UEImage2(
                    widget.images[i],
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_imagePos + 1}/${widget.images.length}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (widget.showThumbnail != null &&
                    widget.showThumbnail == true)
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 15),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 0; i < widget.images.length; i++)
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(right: 5),
                            child: TextButton(
                              onPressed: () =>
                                  buttonCarouselController.jumpToPage(i),
                              style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: UEImage2(
                                  widget.images[
                                      i], // Replace with your image path
                                  fit: BoxFit
                                      .contain, // Adjust the fit as needed
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
