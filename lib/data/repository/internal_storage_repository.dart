import 'package:music_player/domain/data_interface/I_internal_storage_repository.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart' as lib;

class InternalStorageRepository implements IInternalStorageRepository {
  final lib.OnAudioQuery _audioQuery = lib.OnAudioQuery();

  @override
  Future<List<SongModel>> get songs async {
    final songs = await _audioQuery.querySongs(
      sortType: null,
      orderType: lib.OrderType.ASC_OR_SMALLER,
      uriType: lib.UriType.EXTERNAL,
      ignoreCase: false,
    );

    return songs.map((song) => SongModel.fromLib(song)).toList();
  }
}
