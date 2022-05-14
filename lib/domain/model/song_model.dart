import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_audio_query/on_audio_query.dart' as lib;

class SongModel {
  final String id;
  final String userId;
  final String uri;
  final String name;
  final String artist;
  final String album;
  final int duration;
  final bool isFavorite;

  const SongModel({
    required this.id,
    required this.uri,
    required this.name,
    required this.artist,
    required this.album,
    required this.duration,
    required this.userId,
    this.isFavorite = false,
  });

  factory SongModel.fromLib(lib.SongModel model) {
    return SongModel(
      id: '',
      userId: '',
      uri: model.uri ?? '',
      name: model.displayName,
      artist: model.artist ?? '',
      album: model.album ?? '',
      duration: model.duration ?? 0,
    );
  }

  SongModel copyWith({
    String? userId,
    bool? isFavorite,
  }) {
    return SongModel(
      id: id,
      userId: userId ?? this.userId,
      uri: uri,
      name: name,
      artist: artist,
      album: album,
      duration: duration,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory SongModel.fromSnapshot(DocumentSnapshot snap) {
    return SongModel(
      id: snap.id,
      userId: snap['userId'],
      uri: snap['uri'],
      name: snap['name'],
      artist: snap['artist'],
      album: snap['album'],
      duration: snap['duration'],
      isFavorite: snap['isFavorite'] ?? false,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'uri': uri,
      'name': name,
      'artist': artist,
      'album': album,
      'duration': duration,
      'isFavorite': isFavorite,
    };
  }
}
