import 'package:annix/controllers/player_controller.dart';
import 'package:annix/services/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';

extension on LyricAlign {
  TextAlign get textAlign {
    switch (this) {
      case LyricAlign.LEFT:
        return TextAlign.left;
      case LyricAlign.RIGHT:
        return TextAlign.right;
      case LyricAlign.CENTER:
        return TextAlign.center;
    }
  }
}

class PlayingLyricUI extends LyricUI {
  final LyricAlign align;

  PlayingLyricUI({this.align = LyricAlign.CENTER});

  @override
  TextStyle getPlayingMainTextStyle() {
    return Get.textTheme.bodyText1!;
  }

  @override
  TextStyle getOtherMainTextStyle() {
    return Get.textTheme.bodyText2!
        .copyWith(color: Get.textTheme.bodyText2?.color?.withOpacity(0.5));
  }

  @override
  double getInlineSpace() => 20;

  @override
  double getLineSpace() => 20;

  @override
  LyricAlign getLyricHorizontalAlign() {
    return this.align;
  }

  @override
  TextStyle getPlayingExtTextStyle() {
    // TODO: custom style
    return TextStyle(color: Colors.grey[300], fontSize: 14);
  }

  @override
  TextStyle getOtherExtTextStyle() {
    // TODO: custom style
    return TextStyle(color: Colors.grey[300], fontSize: 14);
  }

  @override
  double getPlayingLineBias() {
    return Global.isDesktop
        ? 0.2 // on desk, we tend to make lyric display at top
        : 0.5; // but on mobile phone, it would look better at the center of the screen
  }

  @override
  Color getLyricHightlightColor() {
    return Get.theme.colorScheme.primary;
  }

  @override
  bool enableLineAnimation() => true;
}

class LyricView extends StatelessWidget {
  final LyricAlign alignment;

  const LyricView({super.key, this.alignment = LyricAlign.CENTER});

  @override
  Widget build(BuildContext context) {
    final PlayerController player = Get.find();
    return Obx(
      () => _LyricView(
        lyric: player.playingLyric.value,
        alignment: alignment,
      ),
    );
  }
}

class _LyricView extends StatelessWidget {
  final LyricAlign alignment;
  final String? lyric;

  const _LyricView({
    Key? key,
    this.lyric,
    this.alignment = LyricAlign.CENTER,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lyric == null) {
      return Text("Loading...");
    } else if (lyric!.isEmpty) {
      return Text("No lyrics found");
    } else {
      return GetBuilder<PlayerController>(
        builder: (player) {
          final model = LyricsModelBuilder.create()
              .bindLyricToMain(lyric!)
              // .bindLyricToExt(lyric) // TODO: translation
              .getModel();
          return StreamBuilder<Duration>(
              stream: player.progress.stream,
              builder: (context, position) {
                return LyricsReader(
                  model: model,
                  lyricUi: PlayingLyricUI(align: alignment),
                  position: (position.data ?? player.progress.value)
                      .inMilliseconds /* + 500 as offset */,
                  // don't know why only playing = false has highlight
                  playing: false,
                  emptyBuilder: () {
                    return SingleChildScrollView(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                          lyric!,
                          textAlign: alignment.textAlign,
                          style:
                              context.textTheme.bodyText1!.copyWith(height: 2),
                        ),
                      ),
                    );
                  },
                );
              });
        },
      );
    }
  }
}