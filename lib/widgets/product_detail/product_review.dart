import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/widgets/common/rating_bar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/product_detail/popup_image_carousel.dart';

class ProducctReview extends StatefulWidget {
  const ProducctReview({super.key});

  @override
  State<ProducctReview> createState() => _ProducctReviewState();
}

class _ProducctReviewState extends State<ProducctReview> {
  bool _replyCollapsed = true;

  // list of image of the current review
  List reviewImages = [
    'https://www.ufoelektronika.com/image/cache/catalog/LG%20TV/43LM5750.3-1000x1000.jpg',
    'https://www.ufoelektronika.com/image/cache/catalog/LG%20TV/43LM5750.2-1000x1000.jpg',
  ];

  void showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupImageCarousel(images: reviewImages);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/128/1326/1326405.png'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rachel',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text('7 terbantu')
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              RatingBar(
                rating: 5,
                size: 18,
              ),
              SizedBox(width: 10),
              Text('1 bulan lalu'),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Gambar jernih berkualitas dan harga terjangkau, pengiriman tepat waktu mantap :)',
          ),

          /* ------------------------------ review images ----------------------------- */
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                for (String reviewImage in reviewImages)
                  GestureDetector(
                    onTap: () => showImagePopup(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          width: 40,
                          height: 50,
                          child: UEImage2(
                            reviewImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /* ---------------------------------- reply --------------------------------- */
          Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _replyCollapsed = !_replyCollapsed;
                    }),
                    child: Row(
                      children: [
                        Text(!_replyCollapsed
                            ? 'Tutup Balasan'
                            : 'Lihat Balasan'),
                        Icon(!_replyCollapsed
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ],
                    ),
                  ),
                ],
              ),
              if (!_replyCollapsed)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* --------------------------------- dummy 1 -------------------------------- */
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black12,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Ufoelektronika',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.primaryColor,
                                ),
                                child: const Text(
                                  'Pejual',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('1 bulan lalu'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'Terima kasih telah berbelanja di Ufoelektronika'),
                        ],
                      ),
                    ),

                    /* --------------------------------- dummy 2 -------------------------------- */
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black12,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rachel',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(width: 5),
                              const Text('1 bulan lalu'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Sy akan beli lagi'),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
