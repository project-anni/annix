// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final String albumId;
  final int discId;
  final int trackId;
  final String? title;
  final String? artist;
  final String? albumTitle;
  final String type;

  const Favorite(
      {required this.id,
      required this.albumId,
      required this.discId,
      required this.trackId,
      this.title,
      this.artist,
      this.albumTitle,
      required this.type});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['album_id'] = Variable<String>(albumId);
    map['disc_id'] = Variable<int>(discId);
    map['track_id'] = Variable<int>(trackId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || albumTitle != null) {
      map['album_title'] = Variable<String>(albumTitle);
    }
    map['type'] = Variable<String>(type);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      albumId: Value(albumId),
      discId: Value(discId),
      trackId: Value(trackId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      albumTitle: albumTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(albumTitle),
      type: Value(type),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      albumId: serializer.fromJson<String>(json['album_id']),
      discId: serializer.fromJson<int>(json['disc_id']),
      trackId: serializer.fromJson<int>(json['track_id']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      albumTitle: serializer.fromJson<String?>(json['album_title']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'album_id': serializer.toJson<String>(albumId),
      'disc_id': serializer.toJson<int>(discId),
      'track_id': serializer.toJson<int>(trackId),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
      'album_title': serializer.toJson<String?>(albumTitle),
      'type': serializer.toJson<String>(type),
    };
  }

  Favorite copyWith(
          {int? id,
          String? albumId,
          int? discId,
          int? trackId,
          Value<String?> title = const Value.absent(),
          Value<String?> artist = const Value.absent(),
          Value<String?> albumTitle = const Value.absent(),
          String? type}) =>
      Favorite(
        id: id ?? this.id,
        albumId: albumId ?? this.albumId,
        discId: discId ?? this.discId,
        trackId: trackId ?? this.trackId,
        title: title.present ? title.value : this.title,
        artist: artist.present ? artist.value : this.artist,
        albumTitle: albumTitle.present ? albumTitle.value : this.albumTitle,
        type: type ?? this.type,
      );

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('albumId: $albumId, ')
          ..write('discId: $discId, ')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumTitle: $albumTitle, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, albumId, discId, trackId, title, artist, albumTitle, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.albumId == this.albumId &&
          other.discId == this.discId &&
          other.trackId == this.trackId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.albumTitle == this.albumTitle &&
          other.type == this.type);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<String> albumId;
  final Value<int> discId;
  final Value<int> trackId;
  final Value<String?> title;
  final Value<String?> artist;
  final Value<String?> albumTitle;
  final Value<String> type;

  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.albumId = const Value.absent(),
    this.discId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumTitle = const Value.absent(),
    this.type = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    required String albumId,
    required int discId,
    required int trackId,
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.albumTitle = const Value.absent(),
    this.type = const Value.absent(),
  })  : albumId = Value(albumId),
        discId = Value(discId),
        trackId = Value(trackId);

  static Insertable<Favorite> custom({
    Expression<int>? id,
    Expression<String>? albumId,
    Expression<int>? discId,
    Expression<int>? trackId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? albumTitle,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (albumId != null) 'album_id': albumId,
      if (discId != null) 'disc_id': discId,
      if (trackId != null) 'track_id': trackId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (albumTitle != null) 'album_title': albumTitle,
      if (type != null) 'type': type,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int>? id,
      Value<String>? albumId,
      Value<int>? discId,
      Value<int>? trackId,
      Value<String?>? title,
      Value<String?>? artist,
      Value<String?>? albumTitle,
      Value<String>? type}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      discId: discId ?? this.discId,
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumTitle: albumTitle ?? this.albumTitle,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (discId.present) {
      map['disc_id'] = Variable<int>(discId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (albumTitle.present) {
      map['album_title'] = Variable<String>(albumTitle.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('albumId: $albumId, ')
          ..write('discId: $discId, ')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('albumTitle: $albumTitle, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class Favorites extends Table with TableInfo<Favorites, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  Favorites(this.attachedDatabase, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _discIdMeta = const VerificationMeta('discId');
  late final GeneratedColumn<int> discId = GeneratedColumn<int>(
      'disc_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
      'track_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _albumTitleMeta = const VerificationMeta('albumTitle');
  late final GeneratedColumn<String> albumTitle = GeneratedColumn<String>(
      'album_title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT \'normal\' CHECK ("type" IN (\'normal\', \'instrumental\', \'absolute\', \'drama\', \'radio\', \'vocal\'))',
      defaultValue: const CustomExpression<String>('\'normal\''));

  @override
  List<GeneratedColumn> get $columns =>
      [id, albumId, discId, trackId, title, artist, albumTitle, type];

  @override
  String get aliasedName => _alias ?? 'favorites';

  @override
  String get actualTableName => 'favorites';

  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('disc_id')) {
      context.handle(_discIdMeta,
          discId.isAcceptableOrUnknown(data['disc_id']!, _discIdMeta));
    } else if (isInserting) {
      context.missing(_discIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    if (data.containsKey('album_title')) {
      context.handle(
          _albumTitleMeta,
          albumTitle.isAcceptableOrUnknown(
              data['album_title']!, _albumTitleMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      albumId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}album_id'])!,
      discId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}disc_id'])!,
      trackId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}track_id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      artist: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}artist']),
      albumTitle: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}album_title']),
      type: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  Favorites createAlias(String alias) {
    return Favorites(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PlaylistData extends DataClass implements Insertable<PlaylistData> {
  final int id;
  final String name;
  final String? cover;
  final String? description;
  final String? remoteId;
  final String? owner;
  final bool? public;
  final int? lastModified;
  final bool hasItems;
  const PlaylistData(
      {required this.id,
      required this.name,
      this.cover,
      this.description,
      this.remoteId,
      this.owner,
      this.public,
      this.lastModified,
      required this.hasItems});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<String>(cover);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String>(owner);
    }
    if (!nullToAbsent || public != null) {
      map['public'] = Variable<bool>(public);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<int>(lastModified);
    }
    map['has_items'] = Variable<bool>(hasItems);
    return map;
  }

  PlaylistCompanion toCompanion(bool nullToAbsent) {
    return PlaylistCompanion(
      id: Value(id),
      name: Value(name),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      owner:
          owner == null && nullToAbsent ? const Value.absent() : Value(owner),
      public:
          public == null && nullToAbsent ? const Value.absent() : Value(public),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
      hasItems: Value(hasItems),
    );
  }

  factory PlaylistData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cover: serializer.fromJson<String?>(json['cover']),
      description: serializer.fromJson<String?>(json['description']),
      remoteId: serializer.fromJson<String?>(json['remote_id']),
      owner: serializer.fromJson<String?>(json['owner']),
      public: serializer.fromJson<bool?>(json['public']),
      lastModified: serializer.fromJson<int?>(json['last_modified']),
      hasItems: serializer.fromJson<bool>(json['has_items']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'cover': serializer.toJson<String?>(cover),
      'description': serializer.toJson<String?>(description),
      'remote_id': serializer.toJson<String?>(remoteId),
      'owner': serializer.toJson<String?>(owner),
      'public': serializer.toJson<bool?>(public),
      'last_modified': serializer.toJson<int?>(lastModified),
      'has_items': serializer.toJson<bool>(hasItems),
    };
  }

  PlaylistData copyWith(
          {int? id,
          String? name,
          Value<String?> cover = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> remoteId = const Value.absent(),
          Value<String?> owner = const Value.absent(),
          Value<bool?> public = const Value.absent(),
          Value<int?> lastModified = const Value.absent(),
          bool? hasItems}) =>
      PlaylistData(
        id: id ?? this.id,
        name: name ?? this.name,
        cover: cover.present ? cover.value : this.cover,
        description: description.present ? description.value : this.description,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        owner: owner.present ? owner.value : this.owner,
        public: public.present ? public.value : this.public,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
        hasItems: hasItems ?? this.hasItems,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cover: $cover, ')
          ..write('description: $description, ')
          ..write('remoteId: $remoteId, ')
          ..write('owner: $owner, ')
          ..write('public: $public, ')
          ..write('lastModified: $lastModified, ')
          ..write('hasItems: $hasItems')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, cover, description, remoteId, owner,
      public, lastModified, hasItems);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistData &&
          other.id == this.id &&
          other.name == this.name &&
          other.cover == this.cover &&
          other.description == this.description &&
          other.remoteId == this.remoteId &&
          other.owner == this.owner &&
          other.public == this.public &&
          other.lastModified == this.lastModified &&
          other.hasItems == this.hasItems);
}

class PlaylistCompanion extends UpdateCompanion<PlaylistData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> cover;
  final Value<String?> description;
  final Value<String?> remoteId;
  final Value<String?> owner;
  final Value<bool?> public;
  final Value<int?> lastModified;
  final Value<bool> hasItems;
  const PlaylistCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cover = const Value.absent(),
    this.description = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.owner = const Value.absent(),
    this.public = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.hasItems = const Value.absent(),
  });
  PlaylistCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.cover = const Value.absent(),
    this.description = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.owner = const Value.absent(),
    this.public = const Value.absent(),
    this.lastModified = const Value.absent(),
    required bool hasItems,
  })  : name = Value(name),
        hasItems = Value(hasItems);
  static Insertable<PlaylistData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? cover,
    Expression<String>? description,
    Expression<String>? remoteId,
    Expression<String>? owner,
    Expression<bool>? public,
    Expression<int>? lastModified,
    Expression<bool>? hasItems,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cover != null) 'cover': cover,
      if (description != null) 'description': description,
      if (remoteId != null) 'remote_id': remoteId,
      if (owner != null) 'owner': owner,
      if (public != null) 'public': public,
      if (lastModified != null) 'last_modified': lastModified,
      if (hasItems != null) 'has_items': hasItems,
    });
  }

  PlaylistCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? cover,
      Value<String?>? description,
      Value<String?>? remoteId,
      Value<String?>? owner,
      Value<bool?>? public,
      Value<int?>? lastModified,
      Value<bool>? hasItems}) {
    return PlaylistCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      remoteId: remoteId ?? this.remoteId,
      owner: owner ?? this.owner,
      public: public ?? this.public,
      lastModified: lastModified ?? this.lastModified,
      hasItems: hasItems ?? this.hasItems,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cover.present) {
      map['cover'] = Variable<String>(cover.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (public.present) {
      map['public'] = Variable<bool>(public.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<int>(lastModified.value);
    }
    if (hasItems.present) {
      map['has_items'] = Variable<bool>(hasItems.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cover: $cover, ')
          ..write('description: $description, ')
          ..write('remoteId: $remoteId, ')
          ..write('owner: $owner, ')
          ..write('public: $public, ')
          ..write('lastModified: $lastModified, ')
          ..write('hasItems: $hasItems')
          ..write(')'))
        .toString();
  }
}

class Playlist extends Table with TableInfo<Playlist, PlaylistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Playlist(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _coverMeta = const VerificationMeta('cover');
  late final GeneratedColumn<String> cover = GeneratedColumn<String>(
      'cover', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _remoteIdMeta = const VerificationMeta('remoteId');
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
      'owner', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _publicMeta = const VerificationMeta('public');
  late final GeneratedColumn<bool> public = GeneratedColumn<bool>(
      'public', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  late final GeneratedColumn<int> lastModified = GeneratedColumn<int>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _hasItemsMeta = const VerificationMeta('hasItems');
  late final GeneratedColumn<bool> hasItems = GeneratedColumn<bool>(
      'has_items', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        cover,
        description,
        remoteId,
        owner,
        public,
        lastModified,
        hasItems
      ];
  @override
  String get aliasedName => _alias ?? 'playlist';
  @override
  String get actualTableName => 'playlist';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    }
    if (data.containsKey('public')) {
      context.handle(_publicMeta,
          public.isAcceptableOrUnknown(data['public']!, _publicMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    if (data.containsKey('has_items')) {
      context.handle(_hasItemsMeta,
          hasItems.isAcceptableOrUnknown(data['has_items']!, _hasItemsMeta));
    } else if (isInserting) {
      context.missing(_hasItemsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      cover: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover']),
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      remoteId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      owner: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}owner']),
      public: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}public']),
      lastModified: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}last_modified']),
      hasItems: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}has_items'])!,
    );
  }

  @override
  Playlist createAlias(String alias) {
    return Playlist(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PlaylistItemData extends DataClass
    implements Insertable<PlaylistItemData> {
  final int id;
  final int playlistId;
  final String type;
  final String? description;
  final String info;
  final String? remoteId;
  final int order;
  const PlaylistItemData(
      {required this.id,
      required this.playlistId,
      required this.type,
      this.description,
      required this.info,
      this.remoteId,
      required this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['playlist_id'] = Variable<int>(playlistId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['info'] = Variable<String>(info);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['order'] = Variable<int>(order);
    return map;
  }

  PlaylistItemCompanion toCompanion(bool nullToAbsent) {
    return PlaylistItemCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      info: Value(info),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      order: Value(order),
    );
  }

  factory PlaylistItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistItemData(
      id: serializer.fromJson<int>(json['id']),
      playlistId: serializer.fromJson<int>(json['playlist_id']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      info: serializer.fromJson<String>(json['info']),
      remoteId: serializer.fromJson<String?>(json['remote_id']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playlist_id': serializer.toJson<int>(playlistId),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
      'info': serializer.toJson<String>(info),
      'remote_id': serializer.toJson<String?>(remoteId),
      'order': serializer.toJson<int>(order),
    };
  }

  PlaylistItemData copyWith(
          {int? id,
          int? playlistId,
          String? type,
          Value<String?> description = const Value.absent(),
          String? info,
          Value<String?> remoteId = const Value.absent(),
          int? order}) =>
      PlaylistItemData(
        id: id ?? this.id,
        playlistId: playlistId ?? this.playlistId,
        type: type ?? this.type,
        description: description.present ? description.value : this.description,
        info: info ?? this.info,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        order: order ?? this.order,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistItemData(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('info: $info, ')
          ..write('remoteId: $remoteId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playlistId, type, description, info, remoteId, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistItemData &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.type == this.type &&
          other.description == this.description &&
          other.info == this.info &&
          other.remoteId == this.remoteId &&
          other.order == this.order);
}

class PlaylistItemCompanion extends UpdateCompanion<PlaylistItemData> {
  final Value<int> id;
  final Value<int> playlistId;
  final Value<String> type;
  final Value<String?> description;
  final Value<String> info;
  final Value<String?> remoteId;
  final Value<int> order;
  const PlaylistItemCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.info = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.order = const Value.absent(),
  });
  PlaylistItemCompanion.insert({
    this.id = const Value.absent(),
    required int playlistId,
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    required String info,
    this.remoteId = const Value.absent(),
    required int order,
  })  : playlistId = Value(playlistId),
        info = Value(info),
        order = Value(order);
  static Insertable<PlaylistItemData> custom({
    Expression<int>? id,
    Expression<int>? playlistId,
    Expression<String>? type,
    Expression<String>? description,
    Expression<String>? info,
    Expression<String>? remoteId,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (info != null) 'info': info,
      if (remoteId != null) 'remote_id': remoteId,
      if (order != null) 'order': order,
    });
  }

  PlaylistItemCompanion copyWith(
      {Value<int>? id,
      Value<int>? playlistId,
      Value<String>? type,
      Value<String?>? description,
      Value<String>? info,
      Value<String?>? remoteId,
      Value<int>? order}) {
    return PlaylistItemCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      type: type ?? this.type,
      description: description ?? this.description,
      info: info ?? this.info,
      remoteId: remoteId ?? this.remoteId,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistItemCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('info: $info, ')
          ..write('remoteId: $remoteId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class PlaylistItem extends Table
    with TableInfo<PlaylistItem, PlaylistItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlaylistItem(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT \'normal\' CHECK ("type" IN (\'normal\', \'dummy\', \'album\'))',
      defaultValue: const CustomExpression<String>('\'normal\''));
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _infoMeta = const VerificationMeta('info');
  late final GeneratedColumn<String> info = GeneratedColumn<String>(
      'info', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _remoteIdMeta = const VerificationMeta('remoteId');
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, playlistId, type, description, info, remoteId, order];
  @override
  String get aliasedName => _alias ?? 'playlist_item';
  @override
  String get actualTableName => 'playlist_item';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info']!, _infoMeta));
    } else if (isInserting) {
      context.missing(_infoMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistItemData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playlistId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}playlist_id'])!,
      type: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      info: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}info'])!,
      remoteId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      order: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
    );
  }

  @override
  PlaylistItem createAlias(String alias) {
    return PlaylistItem(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY("playlist_id") REFERENCES "playlist"("id")'];
  @override
  bool get dontWriteConstraints => true;
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final Favorites favorites = Favorites(this);
  late final Index favoritesIndex = Index('favorites_index',
      'CREATE UNIQUE INDEX IF NOT EXISTS favorites_index ON favorites (album_id, disc_id, track_id)');
  late final Playlist playlist = Playlist(this);
  late final PlaylistItem playlistItem = PlaylistItem(this);

  Selectable<PlaylistItemData> playlistItems(int var1) {
    return customSelect(
        'SELECT * FROM playlist_item WHERE playlist_id = ?1 ORDER BY "order"',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          playlistItem,
        }).asyncMap(playlistItem.mapFromRow);
  }

  Selectable<bool> isTrackFavorite(String var1, int var2, int var3) {
    return customSelect(
        'SELECT EXISTS (SELECT 1 AS _c1 FROM favorites WHERE album_id = ?1 AND disc_id = ?2 AND track_id = ?3) AS _c0',
        variables: [
          Variable<String>(var1),
          Variable<int>(var2),
          Variable<int>(var3)
        ],
        readsFrom: {
          favorites,
        }).map((QueryRow row) => row.read<bool>('_c0'));
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favorites, favoritesIndex, playlist, playlistItem];
}
