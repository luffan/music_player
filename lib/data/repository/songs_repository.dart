import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';

class SongsRepository implements ISongsRepository {
  final _songsCollection = FirebaseFirestore.instance.collection('songs');

  @override
  Stream<List<SongModel>> get songs =>
      _songsCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => SongModel.fromSnapshot(doc)).toList();
      });

  @override
  void add(SongModel song) {
    _songsCollection.add(song.toDocument());
  }

  @override
  void addAll(List<SongModel> songs) {
    for (final song in songs) {
      add(song);
    }
  }

  @override
  Future<List<SongModel>> getSongsById(String id) async {
    final snapshot = await _songsCollection.get();
    return snapshot.docs
        .map((doc) => SongModel.fromSnapshot(doc))
        .where((song) => song.id == id)
        .toList();
  }
}
