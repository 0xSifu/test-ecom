import 'package:ufo_elektronika/screens/home/widgets/youtube_live/youtube_live_controller.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class YoutubeLive extends GetView<YoutubeLiveController> {
  const YoutubeLive({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state == null || state.liveYoutubeStatus != 1) {
          return SizedBox.shrink();
        }

        String videoId = YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=${state?.liveYoutube}',
        ) ?? '';

        return YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
        );
      },
      onLoading: const Center(child: CircularProgressIndicator()),
      onError: (error) => Text(error.toString()),
    );
  }
}