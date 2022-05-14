import 'package:music_player/domain/model/song_model.dart';

abstract class IInternalStorageRepository {
  Future<List<SongModel>> get songs;
}