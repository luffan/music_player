import 'enum/playback_option_song.dart';

class SongParameter {
  final bool isPlaying;
  final PlaybackOptionSong option;
  final int indexCurrentSong;
  final int currentDuration;

  const SongParameter({
    this.isPlaying = false,
    this.option = PlaybackOptionSong.usual,
    this.indexCurrentSong = 0,
    this.currentDuration = 0,
  });

  factory SongParameter.fromMap(Map<String, dynamic> snap) {
    return SongParameter(
      isPlaying: snap['isPlaying'] ?? false,
      option: PlaybackOptionSongExt.getByName(snap['option']) ??
          PlaybackOptionSong.usual,
      indexCurrentSong: snap['indexCurrentSong'] ?? 0,
      currentDuration: snap['currentDuration'] ?? 0,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'isPlaying': isPlaying,
      'option': option.name,
      'indexCurrentSong': indexCurrentSong,
      'currentDuration': currentDuration,
    };
  }
}
