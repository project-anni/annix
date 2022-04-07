import 'package:annix/models/anniv.dart';
import 'package:annix/services/audio_source.dart';
import 'package:annix/services/global.dart';
import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart'
    show MediaItem;
import 'package:uuid/uuid.dart';

class AnnilClient {
  final Dio client;
  final String id;
  final String name;
  final String url;
  final String token;
  final int priority;
  final bool local;

  // cached album list in client
  List<String> albums = [];

  AnnilClient._({
    required this.id,
    required this.name,
    required this.url,
    required this.token,
    required this.priority,
    this.local = false,
  }) : client = Dio(BaseOptions(baseUrl: url));

  factory AnnilClient.remote({
    required String id,
    required String name,
    required String url,
    required String token,
    required int priority,
  }) =>
      AnnilClient._(
        id: id,
        name: name,
        url: url,
        token: token,
        priority: priority,
        local: false,
      );

  factory AnnilClient.local({
    required String name,
    required String url,
    required String token,
    required int priority,
  }) =>
      AnnilClient._(
        id: Uuid().v4(),
        name: name,
        url: url,
        token: token,
        priority: priority,
        local: true,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'token': token,
      'priority': priority,
      'local': local,
      'albums': albums,
    };
  }

  factory AnnilClient.fromJson(Map<String, dynamic> json) {
    final client = AnnilClient._(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      token: json['token'] as String,
      priority: json['priority'] as int,
      local: json['local'] as bool,
    );
    client.albums = (json['albums'] as List<dynamic>)
        .map((album) => album as String)
        .toList();
    return client;
  }

  Future<dynamic> _request({
    required String path,
    ResponseType responseType = ResponseType.bytes,
  }) async {
    var resp = await client.get(
      '$path',
      options: Options(
        responseType: responseType,
        headers: {
          'Authorization': this.token,
        },
      ),
    );
    return resp.data;
  }

  /// Get the available album list of an Annil server.
  /// TODO: handle cache correctly
  Future<List<String>> getAlbums() async {
    List<dynamic> result =
        await _request(path: '/albums', responseType: ResponseType.json);
    albums = result.map((e) => e.toString()).toList();
    return List.unmodifiable(albums);
  }

  Future<AudioSource> getAudio({
    required String albumId,
    required int discId,
    required int trackId,
    PreferQuality preferBitrate = PreferQuality.Lossless,
  }) {
    return AnnilAudioSource.create(
      annil: this,
      albumId: albumId,
      discId: discId,
      trackId: trackId,
      preferBitrate: preferBitrate,
    );
  }

  String getCoverUrl({required String albumId, int? discId}) {
    if (discId == null) {
      return '$url/$albumId/cover';
    } else {
      return '$url/$albumId/$discId/cover';
    }
  }
}

class AnnilAudioSource extends ModifiedLockCachingAudioSource {
  final String albumId;
  final int discId;
  final int trackId;

  AnnilAudioSource._({
    required String baseUri,
    required String authorization,
    required this.albumId,
    required this.discId,
    required this.trackId,
    PreferQuality preferBitrate = PreferQuality.Lossless,
    required MediaItem tag,
  }) : super(
          Uri.parse(
            '$baseUri/$albumId/$discId/$trackId?auth=$authorization&prefer_quality=${preferBitrate.toBitrateString()}',
          ),
          tag: tag,
        );

  static Future<AnnilAudioSource> create({
    required AnnilClient annil,
    required String albumId,
    required int discId,
    required int trackId,
    PreferQuality preferBitrate = PreferQuality.Medium,
  }) async {
    var track = await Global.metadataSource!
        .getTrack(albumId: albumId, discId: discId, trackId: trackId);
    return AnnilAudioSource._(
      baseUri: annil.url,
      authorization: annil.token,
      albumId: albumId,
      discId: discId,
      trackId: trackId,
      preferBitrate: preferBitrate,
      tag: MediaItem(
        id: '$albumId/$discId/$trackId',
        title: track?.title ?? "Unknown Title",
        album: track?.disc.album.title ?? "Unknown Album",
        artist: track?.artist,
        artUri: Uri.parse(annil.getCoverUrl(albumId: albumId)),
        displayDescription: track?.type.toString() ?? "normal",
      ),
    );
  }

  TrackInfoWithAlbum toTrack() {
    MediaItem tag = this.tag;

    return TrackInfoWithAlbum(
      track: TrackIdentifier(
        albumId: this.albumId,
        discId: this.discId,
        trackId: this.trackId,
      ),
      info: TrackInfo(
        title: tag.title,
        artist: tag.artist!,
        tags: [],
        type: tag.displayDescription!,
      ),
    );
  }
}

enum PreferQuality {
  Low,
  Medium,
  High,
  Lossless,
}

extension PreferBitrateToString on PreferQuality {
  String toBitrateString() {
    switch (this) {
      case PreferQuality.Low:
        return "low";
      case PreferQuality.Medium:
        return "medium";
      case PreferQuality.High:
        return "high";
      case PreferQuality.Lossless:
        return "lossless";
    }
  }
}
