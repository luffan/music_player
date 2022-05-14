import 'package:music_player/domain/data_interface/I_internal_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_local_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class SongUseCase {
  final ILocalStorageRepository _localStorageRepository;
  final ISongsRepository _songsRepository;
  final IInternalStorageRepository _internalStorageRepository;

  const SongUseCase(
    this._localStorageRepository,
    this._songsRepository,
    this._internalStorageRepository,
  );

  Future<void> loadSongs(String id) async {
    await Permission.storage.request();
    final isSaveSongs = await _localStorageRepository.getIsSaveDate();

    if (!isSaveSongs) {
      final songs = await _internalStorageRepository.songs;

      _songsRepository.addAll(
        songs.map((song) => song.copyWith(userId: id)).toList(),
      );

      _localStorageRepository.setIsSaveDate(true);
    }
  }
}
