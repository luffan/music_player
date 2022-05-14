import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/domain/model/enum/playback_option_song.dart';

extension PlayBackOptionExt on PlaybackOptionSong {
  PlaybackOptionSong changeOption() {
    switch (this) {
      case PlaybackOptionSong.repeat:
       return PlaybackOptionSong.mix;
      case PlaybackOptionSong.mix:
       return PlaybackOptionSong.usual;
      case PlaybackOptionSong.usual:
        return PlaybackOptionSong.repeat;
    }
  }

  IconData get icon {
    switch (this) {

      case PlaybackOptionSong.repeat:
       return Icons.repeat_one;
      case PlaybackOptionSong.mix:
        return Icons.shuffle;
      case PlaybackOptionSong.usual:
        return Icons.repeat;
    }
  }
}