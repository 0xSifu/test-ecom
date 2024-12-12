import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/common/rating_bar.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';
import 'package:ufo_elektronika/widgets/product_detail/product_review.dart';

class ProductReviewScreen extends StatefulWidget {
  static const routeName = "/product-review";
  const ProductReviewScreen({super.key});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  Map<String, dynamic> filter = {
    'rating': null,
    'withComment': false,
    'withMedia': false,
  };

  void changeRating() {
    setState(() {});
  }

  /* ------------------------------ rating filter ----------------------------- */
  void filterRating(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => ModalBottomSheetDefault(
            title: 'Rating',
            child: (scrollController) => Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i < 6; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "$i",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                            child: Radio(
                              value: i,
                              groupValue: filter['rating'],
                              onChanged: (value) => setState(() {
                                filter['rating'] = i;
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => setState(() {
                          filter['rating'] = null;
                        }),
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            changeRating();
                            Navigator.pop(context);
                          },
                          child: const Text('Konfirmasi'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UEAppBar(
        title: 'Penilaian Produk',
        showCart: false,
        showNotification: false,
      ),
      body: DefaultLayout(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  color: const Color(0x1FAEAEAE),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '5',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '/5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const RatingBar(
                        rating: 5,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              /* --------------------------------- filter --------------------------------- */
              SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // reset filter
                    if (filter['rating'] != null)
                      GestureDetector(
                        onTap: () => setState(() {
                          filter = {
                            'rating': null,
                            'withComment': false,
                            'withMedia': false,
                          };
                        }),
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          color: const Color(0x1FAEAEAE),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () => filterRating(context),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          color: filter['rating'] == null
                              ? const Color(0x1FAEAEAE)
                              : Colors.blue[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (filter['rating'] == null)
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rating',
                                    ),
                                    Icon(Icons.expand_more),
                                  ],
                                ),
                              if (filter['rating'] != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      filter['rating'].toString(),
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    Icon(
                                      Icons.expand_more,
                                      color: Colors.blue[900],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          filter['withComment'] = !filter['withComment'];
                        }),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          alignment: Alignment.center,
                          color: filter['withComment'] == null ||
                                  filter['withComment'] == false
                              ? const Color(0x1FAEAEAE)
                              : Colors.blue[50],
                          child: Text(
                            'Dengan Komentar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: filter['withComment'] == null ||
                                      filter['withComment'] == false
                                  ? Colors.black
                                  : Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          filter['withMedia'] = !filter['withMedia'];
                        }),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          alignment: Alignment.center,
                          color: filter['withMedia'] == null ||
                                  filter['withMedia'] == false
                              ? const Color(0x1FAEAEAE)
                              : Colors.blue[50],
                          child: Text(
                            'Dengan Media',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: filter['withMedia'] == null ||
                                      filter['withMedia'] == false
                                  ? Colors.black
                                  : Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /* ------------------------------ review list ------------------------------ */
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Column(
                      children: [
                        ProducctReview(),
                        ProducctReview(),
                        ProducctReview(),
                        ProducctReview(),
                        ProducctReview(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
