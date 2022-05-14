import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/domain/model/enum/playback_option_song.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/domain/model/song_parameter.dart';
import 'package:music_player/domain/model/user.dart';
import 'package:music_player/domain/usecase/audio_player_usecase.dart';
import 'package:music_player/domain/usecase/user_usecase.dart';
import 'package:music_player/presentation/pages/song_page/song_state.dart';
import 'package:music_player/presentation/utils/extension/play_back_option_song_ext.dart';

class SongCubit extends Cubit<SongState> {
  final AudioPlayerUseCase _audioPlayerUseCase;
  final UserUseCase _userUseCase;

  SongCubit(
    this._audioPlayerUseCase,
    this._userUseCase,
  ) : super(
          const SongState(
            indexCurrentSong: -1,
            currentTime: Duration(),
            songs: [],
            userStatus: UserStatus.none,
            isPlaying: false,
            option: PlaybackOptionSong.usual,
          ),
        );

  StreamSubscription? _positionChange;
  StreamSubscription? _playingState;
  StreamSubscription? _userSubscription;

  void init() async {
    _positionChange?.cancel();
    _positionChange = _audioPlayerUseCase.onDurationChange.listen((duration) {
      // _userUseCase.updateUser(
      //   songParameter: SongParameter(
      //     isPlaying: state.isPlaying,
      //     option: state.option,
      //     indexCurrentSong: state.indexCurrentSong,
      //     currentDuration: duration.inSeconds,
      //   ),
      // );
      emit(
        state.copyWith(currentTime: duration),
      );
    });

    _playingState?.cancel();
    _playingState = _audioPlayerUseCase.onPlayerCompletion.listen(
      (audioState) {
        if (audioState == ProcessingState.completed) {
          final indexNextSong = state.option.next(
            state.indexCurrentSong,
          );

          emit(state.copyWith(isPlaying: false));

          _userUseCase.updateUser(
            songParameter: SongParameter(
              isPlaying: false,
              option: state.option,
              indexCurrentSong: state.indexCurrentSong,
            ),
          );

          _audioPlayerUseCase.stop();

          _audioPlayerUseCase.play(state.songs[indexNextSong].uri);

          _userUseCase.updateUser(
            songParameter: SongParameter(
              isPlaying: true,
              option: state.option,
              indexCurrentSong: indexNextSong,
            ),
          );

          emit(
            state.copyWith(
              indexCurrentSong: indexNextSong,
              isPlaying: true,
            ),
          );
        }
      },
    );

    _userSubscription?.cancel();
    _userSubscription = (await _userUseCase.user).listen((user) async {
      if (user.status == UserStatus.listener) {
        _userListener(user);
      }
    });
  }

  void _userListener(User user) {
    final indexCurrentSong = user.songParameter.indexCurrentSong;
    final isPlaying = user.songParameter.isPlaying;
    final option = user.songParameter.option;
    final currentTime = Duration(
      seconds: user.songParameter.currentDuration,
    );

    final differenceIndexes = indexCurrentSong - state.indexCurrentSong;

    if (differenceIndexes == 1) {
      playNext();
    } else if (differenceIndexes == -1) {
      playPrevious();
    }

    if (state.isPlaying && !isPlaying) {
      _pause();
    }

    if (!state.isPlaying && isPlaying) {
      _resume();
    }

    if (state.option != option) {
      changeSongStatus();
    }

    final timeDifferences =
        (currentTime.inSeconds - state.currentTime.inSeconds).abs();
    if (timeDifferences > 1) {
      positionChanged(currentTime.inSeconds);
    }
  }

  void startPlaying(int currentSong, List<SongModel> songs) async {
    _audioPlayerUseCase.play(songs[currentSong].uri);

    _userUseCase.updateUser(
      isSongPage: true,
      songParameter: SongParameter(
        isPlaying: true,
        option: state.option,
        indexCurrentSong: currentSong,
      ),
    );

    emit(
      state.copyWith(
        songs: songs,
        indexCurrentSong: currentSong,
        isPlaying: true,
      ),
    );
  }

  void onControllCircleTap() {
    if (state.isPlaying) {
      _pause();
    } else {
      _resume();
    }
  }

  void changeSongStatus() {
    final option = state.option.changeOption();

    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: state.isPlaying,
        option: option,
        indexCurrentSong: state.indexCurrentSong,
      ),
    );

    emit(
      state.copyWith(
        option: state.option.changeOption(),
      ),
    );
  }

  void playNext() {
    final indexNextSong = state.indexCurrentSong == state.songs.length - 1
        ? 0
        : state.indexCurrentSong + 1;

    _audioPlayerUseCase.play(state.songs[indexNextSong].uri);

    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: state.isPlaying,
        option: state.option,
        indexCurrentSong: indexNextSong,
      ),
    );

    emit(
      state.copyWith(
        indexCurrentSong: indexNextSong,
      ),
    );
  }

  void playPrevious() {
    final indexPreviousSong = state.indexCurrentSong == 0
        ? state.songs.length - 1
        : state.indexCurrentSong - 1;

    _audioPlayerUseCase.play(state.songs[indexPreviousSong].uri);

    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: state.isPlaying,
        option: state.option,
        indexCurrentSong: indexPreviousSong,
      ),
    );

    emit(
      state.copyWith(
        indexCurrentSong: indexPreviousSong,
      ),
    );
  }

  void _pause() {
    _audioPlayerUseCase.stop();

    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: false,
        option: state.option,
        indexCurrentSong: state.indexCurrentSong,
      ),
    );

    emit(
      state.copyWith(
        isPlaying: false,
      ),
    );
  }

  void _resume() {
    _audioPlayerUseCase.resume();

    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: true,
        option: state.option,
        indexCurrentSong: state.indexCurrentSong,
      ),
    );

    emit(
      state.copyWith(
        isPlaying: true,
      ),
    );
  }

  void positionChanged(int seconds) {
    final updateDuration = Duration(seconds: seconds);
    _userUseCase.updateUser(
      songParameter: SongParameter(
        isPlaying: state.isPlaying,
        option: state.option,
        indexCurrentSong: state.indexCurrentSong,
        currentDuration: seconds,
      ),
    );
    _audioPlayerUseCase.seek(updateDuration);
  }

  void resetTransition() {
    _userUseCase.updateUser(isSongPage: false);
  }
}
