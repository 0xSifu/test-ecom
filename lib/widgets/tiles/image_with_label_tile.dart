import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class ImageWithLabelTile extends StatelessWidget {
  const ImageWithLabelTile({
    super.key,
    required this.image,
    required this.label,
    this.url,
  });

  /// image url
  final String image;

  /// label
  final String label;

  /// url link
  final String? url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (url!.isNotEmpty) Get.toNamed(url!)},
      child: Container(
        width: 90,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: UEImage2(
                image
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
