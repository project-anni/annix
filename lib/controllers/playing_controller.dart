import 'dart:math';

import 'package:annix/controllers/annil_controller.dart';
import 'package:annix/controllers/anniv_controller.dart';
import 'package:annix/models/metadata.dart';
import 'package:annix/services/global.dart';
import 'package:audio_service/audio_service.dart';
import 'package:f_logs/f_logs.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class _PlayingQueue {
  final AnnivController anniv = Get.find();

  final List<MediaItem> queue;
  int index;

  _PlayingQueue({required this.queue, required this.index});

  bool get isEmpty => this.queue.isEmpty;
  int get length => this.queue.length;
  MediaItem get playing => this.queue[this.index];

  bool _isPlayingFavorited = false;
  bool get isPlayingFavorited => _isPlayingFavorited;

  updateFavorited() {
    if (this.index < this.queue.length) {
      final item = this.queue[this.index];
      this._isPlayingFavorited = anniv.favorites.containsKey(item.id);
    } else {
      this._isPlayingFavorited = false;
    }
  }
}

class PlayingController extends GetxController {
  AudioPlayer player = AudioPlayer();

  final AnnivController anniv = Get.find();

  @override
  onInit() {
    super.onInit();

    this.isPlaying.bindStream(player.playingStream);
    this.progress.bindStream(player.positionStream);
    this.duration.bindStream(player.durationStream);
    this.bufferedMap.listen((map) {
      final id = this.currentPlaying.value?.id;
      if (id != null) {
        final buffered = map[id];
        if (buffered != null) {
          this.buffered.value = buffered;
          return;
        }
      }
      this.buffered.value = Duration.zero;
    });

    this.loopMode.bindStream(player.loopModeStream);
    this.shuffleEnabled.bindStream(player.shuffleModeEnabledStream);
    this.player.currentIndexStream.listen((index) {
      if (index != null) {
        this.queue.value?.index = index;
        this.queue.value?.updateFavorited();
        this.queue.refresh();
      }
    });
    this.anniv.favorites.listen((_) {
      this.queue.value?.updateFavorited();
      this.queue.refresh();
    });

    this.player.setAudioSource(ConcatenatingAudioSource(children: []));

    this.currentPlaying.bindStream(queue.stream.map((e) {
      if (e == null || e.isEmpty) {
        return null;
      } else {
        return e.playing;
      }
    }));
  }

  Rx<bool> isPlaying = false.obs;
  Rx<LoopMode> loopMode = LoopMode.off.obs;
  Rx<bool> shuffleEnabled = false.obs;

  Rx<Duration> progress = Duration.zero.obs;
  Rx<Duration> buffered = Duration.zero.obs;
  RxMap<String, Duration> bufferedMap = RxMap<String, Duration>();
  Rxn<Duration> duration = Rxn();

  RxMap<String, Duration> durationMap = RxMap();

  Future<void> play() async {
    FLog.trace(text: "Start playing");
    await player.play();
  }

  Future<void> pause() async {
    FLog.trace(text: "Pause playing");
    await player.pause();
  }

  Future<void> playOrPause() async {
    if (this.isPlaying.value) {
      await this.pause();
    } else {
      await this.play();
    }
  }

  Future<void> previous() async {
    FLog.trace(text: "Seek to previous");
    await player.seekToPrevious();
  }

  Future<void> next() async {
    FLog.trace(text: "Seek to next");
    await player.seekToNext();
  }

  Future<void> seek(Duration position) async {
    FLog.trace(text: "Seek to position $position");
    await player.seek(position);
  }

  Future<void> jump(int index) async {
    FLog.trace(text: "Jump to $index in playing queue");
    await player.seek(Duration.zero, index: index);
  }

  Future<void> setLoopMode(LoopMode mode) async {
    FLog.trace(text: "Set loop mode $mode");
    await player.setLoopMode(mode);
  }

  Future<void> setShuffleModeEnabled(bool enable) async {
    FLog.trace(text: "Shuffle mode enabled: $enable");
    await player.setShuffleModeEnabled(enable);
  }

  // Playing queue
  Rxn<_PlayingQueue> queue = Rxn();
  Rxn<MediaItem> currentPlaying = Rxn();

  Future<void> setPlayingQueue(List<IndexedAudioSource> songs,
      {int initialIndex = 0}) async {
    await pause();

    queue.value = _PlayingQueue(
      queue: songs.map((e) => e.tag as MediaItem).toList(),
      index: initialIndex,
    );

    final playQueue = ConcatenatingAudioSource(children: songs);
    await player.setAudioSource(playQueue, initialIndex: initialIndex);
    await play();
  }

  Duration getDuration(String id) {
    return this.durationMap[id] ?? this.duration.value ?? Duration.zero;
  }

  Future<void> fullShuffleMode({int count = 30}) async {
    AnnilController annil = Get.find();
    final albums = annil.albums.toList();
    final rand = Random();

    final songs = <IndexedAudioSource>[];
    final albumIds = <String>[];

    for (int i = 0; i < count; i++) {
      final albumId = albums[rand.nextInt(albums.length)];
      albumIds.add(albumId);
    }

    final metadataMap =
        await (await Global.metadataSource.future).getAlbums(albumIds);
    for (final albumId in albumIds) {
      final metadata = metadataMap[albumId];
      if (metadata != null) {
        // random disc in metadata
        final discIndex = rand.nextInt(metadata.discs.length);
        final disc = metadata.discs[discIndex];
        // random track
        final trackIndex = rand.nextInt(disc.tracks.length);
        final track = disc.tracks[trackIndex];

        if (track.type == TrackType.Normal) {
          songs.add(await annil.getAudio(
            albumId: albumId,
            discId: discIndex + 1,
            trackId: trackIndex + 1,
          ));
        }
      }
    }

    await this.setLoopMode(LoopMode.off);
    await this.setShuffleModeEnabled(false);
    await this.setPlayingQueue(songs);
  }

  Future<void> toggleFavorite() async {
    this.anniv.toggleFavorite(this.currentPlaying.value!.id);
  }
}
