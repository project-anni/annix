import 'package:annix/models/metadata.dart';
import 'package:annix/utils/store.dart';

/// MetadataSource is the source of local metadata need by the whole application.
///
/// It can be folder with structure defined in [Anni Metadata Repository][metadata-repository], or pre-compiled sqlite database file.
///
/// [metadata-repository]: https://book.anni.rs/02.metadata-repository/00.readme.html
abstract class BaseMetadataSource {
  /// Prepare for metadata source
  Future<void> prepare();

  /// Update metadata source by calling [doUpdate]
  ///
  /// [doUpdate] might be called when caller [force] to update,
  /// or when [canUpdate] returns true
  ///
  /// This function returns whether an update is done actually.
  Future<bool> update({force = false}) async {
    if (force || await canUpdate()) {
      bool updated = await doUpdate();
      if (updated) {
        // metadata repository updated, invalidate cache
        await _albumStore.clear();
      }
      return updated;
    }
    return false;
  }

  /// Controls whether to update metadata when not forced
  Future<bool> canUpdate() async {
    return false;
  }

  /// The actual update part. Override this function with actual implementation.
  Future<bool> doUpdate() async {
    return false;
  }

  /// Whether a metadata source needs to be cached
  bool get needPersist;

  /// Private album object cache for album object reading
  static final _albumStore = AnnixStore().category('album');

  /// Get album information
  ///
  /// DO NOT OVERRIDE THIS METHOD
  Future<Album?> getAlbum({required String albumId}) async {
    if (!await _albumStore.contains(albumId)) {
      // album not in cache, load it from source
      Album? album = await getAlbumDetail(albumId: albumId);
      if (album == null) {
        //  album not found
        return null;
      } else if (this.needPersist) {
        // album need persist
        await _albumStore.set(albumId, album.toJson());
      }
      return album;
    }
    final data = await _albumStore.get(albumId);
    return Album.fromJson(data!);
  }

  /// Actual method to get album detail from metadata source
  /// Override this function to grant ability to get album detail
  ///
  /// Return null if album is not found
  Future<Album?> getAlbumDetail({required String albumId});

  /// Get track information
  ///
  /// DO NOT OVERRIDE THIS METHOD
  Future<Track?> getTrack({
    required String albumId,
    required int discId,
    required int trackId,
  }) async {
    Album? album = await getAlbum(albumId: albumId);
    return album?.discs[discId - 1].tracks[trackId - 1];
  }
}
