import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/enums.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart' as super_deal;
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class NewProducttile extends StatelessWidget {
  const NewProducttile(
      {super.key,
      required this.product,
      this.productTileType = ProductTileType.normal});

  /// product
  final super_deal.Product product;

  /// product tile type
  /// bestseller, flashSale or normal
  final ProductTileType? productTileType;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => Get.toNamed(ProductScreen.routeName, parameters: {"id": product.productId}, preventDuplicates: false),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFEEEEEE),
            width: 0.5,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Wrap(
            children: [
              // image
              AspectRatio(
                aspectRatio: 1,
                child: UEImage2(
                  product.thumb,
                  fit: BoxFit.contain
                ),
              ),

              const SizedBox(height: 7),

              Container(
                // height: contentHeight,
                // color: Colors.yellowAccent,
                padding: const EdgeInsets.only(
                  top: 7,
                  left: 10,
                  right: 10,
                  bottom: 7,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // title
                    Stack(
                      children: [
                        SizedBox(
                          width: 0,
                          child: IgnorePointer(
                            child: Opacity(
                              opacity: 0.0,
                              child: Text("lalalala\nlalala",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: productTileType == ProductTileType.superDeal
                                    ? TextAlign.center
                                    : TextAlign.left,
                                style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 13,
                                  fontFamily: 'MYRIADPRO',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product.name.toUpperCase().trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: productTileType == ProductTileType.superDeal
                                    ? TextAlign.center
                                    : TextAlign.left,
                                style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 13,
                                  fontFamily: 'MYRIADPRO',
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (productTileType == ProductTileType.normal)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (product.rating > 0)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star, color: AppColor.yellow, size: 15),
                                    const SizedBox(width: 2),
                                    Text(product.rating.toInt().toString(), style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'MYRIADPRO',
                                        )),
                                  ],
                                )
                              else
                                // Prototype to give height
                                SizedBox(
                                  width: 0,
                                  child: IgnorePointer(
                                    child: Opacity(
                                      opacity: 0.0,
                                      child: Text(product.rating.toInt().toString(), style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'MYRIADPRO',
                                      )),
                                    ),
                                  ),
                                ),
                              if (product.totalSales != null && product.totalSales!.isNotEmpty && (int.tryParse(product.totalSales?.toString() ?? "0") ?? 0) > 0)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (product.rating > 0)
                                      Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          Container(
                                            color: Colors.grey,
                                            width: 1,
                                            height: 11,
                                          ),
                                          const SizedBox(width: 4),
                                        ],
                                      ),
                                    Text("Terjual: ${product.totalSales ?? " "}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'MYRIADPRO',
                                      )
                                    )
                                  ],
                                )
                            ],
                          ),

                        // price
                        if (productTileType != ProductTileType.superDeal)
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* ----------------------------- Default Tile ---------------------------- */
                                if (productTileType != ProductTileType.bestseller)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 7),
                                      Text(product.special ?? product.priceFlashSale ?? product.price,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'MYRIADPRO',
                                          color: Color(0xFFfbaa1a),
                                          fontSize: 15
                                        ),
                                      ),

                                      // discount price
                                      if (product.special != null &&
                                          productTileType != ProductTileType.flashSale)
                                          Row(
                                            children: [
                                              if (product.disc != null)
                                                Row(
                                                  children: [
                                                    discountRedBox(product.disc?.toStringAsFixed(0) ?? ""),
                                                    const SizedBox(width: 5)
                                                  ],
                                                ),
                                              Expanded(
                                                child: Text(product.price,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      else if (productTileType == ProductTileType.flashSale && product.disc != null && product.disc! > 0)
                                        Row(
                                            children: [
                                              Text(product.price,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'MYRIADPRO',
                                                  color: Theme.of(context).disabledColor,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              discountRedBox(product.disc?.toStringAsFixed(0) ?? ""),
                                            ],
                                          )
                                      else
                                        // Prototype to give height
                                        SizedBox(
                                          width: 0,
                                          child: IgnorePointer(
                                            child: Opacity(
                                              opacity: 0.0,
                                              child: discountRedBox(""),
                                            ),
                                          ),
                                        ),

                                    ],
                                  ),

                                /* ---------------------------- Best Seller Tile ---------------------------- */
                                if (productTileType == ProductTileType.bestseller)
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.yellow,
                                    ),
                                    child: Text(
                                      "Penjualan ${product.total?.toString()}+ / Bulan"
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: sizer.Device.screenType == sizer.ScreenType.tablet ? 9.3 : 9.spa,
                                        fontFamily: 'MYRIADPRO',
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                        /* ------------------------------- Super Deal ------------------------------- */
                        if (productTileType == ProductTileType.superDeal)
                          Stack(
                            children: [
                              // original price
                              if (product.special != null)
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product.special!,
                                    style: TextStyle(
                                      fontSize: sizer.Device.screenType == sizer.ScreenType.tablet ? 13 : 11.spa,
                                      fontFamily: 'MYRIADPRO',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              // discount price
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.yellow,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        product.price,
                                        style: TextStyle(
                                          fontSize: sizer.Device.screenType == sizer.ScreenType.tablet ? 8.4 : 8.4.spa,
                                          fontFamily: 'MYRIADPRO',
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primaryColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        /* ----------------------------- Flash Sale Tile ---------------------------- */
                        if (productTileType == ProductTileType.flashSale)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 23,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(38),
                                        color: const Color(0xFFfbeabf),
                                      ),
                                    ),
                                    // if (product.amountSold != null ||
                                    //     product.amount != null)
                                    //   Positioned(
                                    //     top: 0,
                                    //     left: 0,
                                    //     child: Container(
                                    //       width: product.amountSold! /
                                    //           product.amount! *
                                    //           150,
                                    //       height: 23,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(38),
                                    //         gradient: product.amountSold != null
                                    //             ? const LinearGradient(
                                    //                 colors: [
                                    //                   Color(0xFFe94e0f),
                                    //                   Color(0xFFfed100)
                                    //                 ],
                                    //                 begin: Alignment.topLeft,
                                    //                 end: Alignment.bottomRight,
                                    //               )
                                    //             : null,
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),

                                // text terjual
                                Container(
                                  height: 23,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.bolt,
                                        size: 20,
                                        color: Color(0xFFfed100),
                                      ),
                                      Text(
                                        '${product.totalSales ?? product.qtySold ?? "0"} Terjual',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF636363),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget discountRedBox(String discountPercentage) => Container(
    padding:
        const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 2,
    ),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius:
          BorderRadius.circular(5),
    ),
    child: Text(
      '$discountPercentage%',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.red.shade600,
      ),
    ),
  );
}