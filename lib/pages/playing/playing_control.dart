import 'package:annix/controllers/annil_controller.dart';
import 'package:annix/controllers/playing_controller.dart';
import 'package:annix/widgets/player_buttons.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayingControl extends StatelessWidget {
  const PlayingControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayingController playing = Get.find();
    final AnnilController annil = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Card(
                elevation: 0,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: "playing-cover",
                    child: Obx(() {
                      final item = playing.currentPlaying.value;
                      if (item == null) {
                        return Container();
                      } else {
                        return annil.cover(albumId: item.id.split('/')[0]);
                      }
                    }),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Obx(
                () => Text(
                  playing.currentPlaying.value?.title ?? "",
                  style: context.textTheme.titleLarge,
                ),
              ),
              Obx(
                () => Text(
                  playing.currentPlaying.value?.artist ?? "",
                  style: context.textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => ProgressBar(
                  progress: playing.progress.value,
                  total: playing.getDuration(
                    playing.currentPlaying.value!.id,
                  ),
                  onSeek: (position) {
                    playing.seek(position);
                  },
                  barHeight: 2.0,
                  thumbRadius: 5.0,
                  thumbCanPaintOutsideBar: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    iconSize: 32,
                    onPressed: () => playing.previous(),
                  ),
                  PlayPauseButton(iconSize: 48),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 32,
                    onPressed: () => playing.next(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}