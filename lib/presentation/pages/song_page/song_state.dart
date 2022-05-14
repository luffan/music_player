import 'package:music_player/domain/model/enum/playback_option_song.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/song_model.dart';

class SongState {
  final UserStatus userStatus;
  final int indexCurrentSong;
  final Duration currentTime;
  final bool isPlaying;
  final PlaybackOptionSong option;
  final List<SongModel> songs;

  const SongState({
    required this.indexCurrentSong,
    required this.currentTime,
    required this.songs,
    required this.userStatus,
    required this.isPlaying,
    required this.option,
  });

  SongModel get currentSong => songs[indexCurrentSong];

  SongState copyWith({
    int? indexCurrentSong,
    Duration? currentTime,
    List<SongModel>? songs,
    UserStatus? userStatus,
    bool? isPlaying,
    PlaybackOptionSong? option,
  }) {
    return SongState(
      indexCurrentSong: indexCurrentSong ?? this.indexCurrentSong,
      currentTime: currentTime ?? this.currentTime,
      songs: songs ?? this.songs,
      userStatus: userStatus ?? this.userStatus,
      isPlaying: isPlaying ?? this.isPlaying,
      option: option ?? this.option,
    );
  }
}
