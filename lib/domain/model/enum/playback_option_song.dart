enum PlaybackOptionSong {
  repeat,
  mix,
  usual,
}

extension PlaybackOptionSongExt on PlaybackOptionSong {
  static PlaybackOptionSong? getByName(String? type) {
    if (type == null) return null;

    return PlaybackOptionSong.values
        .where((option) => option.name == type)
        .first;
  }

  int next(int index) {
    switch (this) {
      case PlaybackOptionSong.repeat:
        return index;
      case PlaybackOptionSong.mix:
        return index + 1;
      case PlaybackOptionSong.usual:
        return index + 1;
    }
  }
}
