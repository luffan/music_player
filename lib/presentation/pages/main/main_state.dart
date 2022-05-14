import 'package:music_player/domain/model/enum/loading_status.dart';
import 'package:music_player/domain/model/song_model.dart';

class MainState {
  final List<SongModel> songs;
  final LoadingStatus loadingStatus;
  final bool goToSongPage;
  final int currentIndex;

  const MainState({
    required this.songs,
    required this.loadingStatus,
    required this.goToSongPage,
    required this.currentIndex,
  });

  MainState copyWith({
    List<SongModel>? songs,
    LoadingStatus? loadingStatus,
    bool? goToSongPage,
    int? currentIndex,
  }) {
    return MainState(
      songs: songs ?? this.songs,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      goToSongPage: goToSongPage ?? this.goToSongPage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
