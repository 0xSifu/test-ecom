import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class WishlistTile extends StatelessWidget {
  const WishlistTile({super.key, required this.product, required this.onDelete, required this.onATC});

  /// product
  final Product product;
  final Function() onDelete;
  final Function() onATC;

  @override
  Widget build(BuildContext context) {
    // content height
    double contentHeight = 100;

    return GestureDetector(
      onTap: () => Get.toNamed(ProductScreen.routeName, parameters: {"id": product.productId}, preventDuplicates: false),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // image
            Expanded(
              child: Stack(children: [
                SizedBox(
                  width: double.infinity,
                  child: UEImage2(
                    product.thumb,
                    fit: BoxFit.contain
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 10),

            Container(
              height: contentHeight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // title
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // price
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.special ?? product.price,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // discount price
                              if (product.special != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      if (product.disc != null)
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "${product.disc?.toStringAsFixed(0)}%",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red.shade600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                      Expanded(
                                        child: Text(
                                          product.price,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).disabledColor,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black38,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 10),
                        ),
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColor.primaryColor),
                        ),
                      ),
                      onPressed: onATC,
                      child: const Text(
                        '+ Keranjang',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
