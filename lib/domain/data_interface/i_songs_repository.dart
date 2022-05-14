import 'package:music_player/domain/model/song_model.dart';

abstract class ISongsRepository {
  Stream<List<SongModel>> get songs;

  void add(SongModel song);

  void addAll(List<SongModel> songs);

  Future<List<SongModel>>  getSongsById(String id);
}