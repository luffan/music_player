import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:music_player/domain/model/song_parameter.dart';

import 'enum/user_status.dart';

class User {
  final String id;
  final String snapId;
  final String connectedId;
  final String name;
  final String email;
  final String avatarUrl;
  final String songsId;
  final UserStatus status;
  final SongParameter songParameter;
  final bool isSongPage;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.songsId,
    required this.connectedId,
    required this.snapId,
    this.isSongPage = false,
    this.status = UserStatus.none,
    this.songParameter = const SongParameter(),
  });

  bool get isNotActive => name.isEmpty && email.isEmpty;

  factory User.fromFirebase(fb.User? user) {
    return User(
      id: user?.uid ?? '',
      snapId: '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      connectedId: '',
      avatarUrl: '',
      songsId: '',
    );
  }

  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      snapId: snap.id,
      id: snap['id'],
      name: snap['name'],
      email: snap['email'],
      avatarUrl: snap['avatarUrl'],
      songsId: snap['songsId'],
      connectedId: snap['connectedId'],
      status: UserStatusExt.getByName(snap['status']) ?? UserStatus.none,
      songParameter: SongParameter.fromMap(snap['songParameter']),
      isSongPage: snap['isSongPage'] ?? false,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'songsId': songsId,
      'status': status.name,
      'connectedId': connectedId,
      'songParameter': songParameter.toDocument(),
      'isSongPage': isSongPage,
    };
  }

  User copyWith({
    String? id,
    String? connectedId,
    UserStatus? status,
    SongParameter? songParameter,
    bool? isSongPage,
  }) {
    return User(
      id: id ?? this.id,
      snapId: snapId,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      songsId: songsId,
      status: status ?? this.status,
      connectedId: connectedId ?? this.connectedId,
      songParameter: songParameter ?? this.songParameter,
      isSongPage: isSongPage ?? this.isSongPage,
    );
  }
}
