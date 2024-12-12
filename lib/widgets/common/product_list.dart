import 'package:flutter/material.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:sizer/sizer.dart' as sizer;

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.products,
  });

  /// product list
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productNoOfColumn = sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2;
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          for (var row = 0; row < (products.length ~/ productNoOfColumn); row++)
            Column(
              children: [
                Builder(
                  builder: (context) {
                    final rowWidget = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const SizedBox(width: 10)],
                    );

                    for (var col = 0; col < productNoOfColumn; col++) {
                      if (products.length > row*productNoOfColumn+col) {
                        rowWidget.children.add(Expanded(child: NewProducttile(product: products[row*productNoOfColumn+col])));
                      } else {
                        rowWidget.children.add(Expanded(child: Container()));
                      }
                      rowWidget.children.add(const SizedBox(width: 7));
                    }
                    rowWidget.children.removeLast();
                    rowWidget.children.add(const SizedBox(width: 10));

                    return rowWidget;
                  },
                ),
                const SizedBox(height: 7),
              ],
            )
        ],
      ),
    );
  }
}
