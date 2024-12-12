import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/news/news_controller.dart';
import 'package:ufo_elektronika/shared/utils/html_unescape/html_unescape.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        title: "UFO NEWS",
        showCart: false,
        showNotification: false,
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: controller.obx((state) {
        if (state == null) return const Center(child: CircularProgressIndicator());
        return RefreshIndicator(
          onRefresh: () async {
            controller.load();
          },
          child: ListView.builder(
            itemCount: state.blog.length,
            itemBuilder: (context, index) {
              final blog = state.blog[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(blog.title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                            Text(DateFormat("d MMMM yyyy").format(blog.start ?? DateTime.now()), style: const TextStyle(fontSize: 12, color: Color(0xFF636363))),
                            const SizedBox(height: 5),
                            UEImage2(blog.image ?? "", width: double.infinity, fit: BoxFit.cover,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Html(data: HtmlUnescape().convert(blog.description ?? ""), onLinkTap: (url, attributes, element) => url != null && url.isNotEmpty ? Get.toNamed(url) : null),
                      ),
                      if (blog.video != null && blog.video!.isNotEmpty && YoutubePlayer.convertUrlToId(blog.video!) != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: YoutubePlayer.convertUrlToId(blog.video!)!,
                              flags: const YoutubePlayerFlags(
                                mute: false,
                                autoPlay: false,
                                disableDragSeek: true,
                                loop: false,
                                isLive: false,
                                forceHD: false,
                                enableCaption: false,
                              )
                            ),
                            showVideoProgressIndicator: false,
                            onReady: () {

                            },
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      })
    );
  }
}