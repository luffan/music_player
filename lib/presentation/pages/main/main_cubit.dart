import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:music_player/domain/model/enum/loading_status.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/domain/usecase/user_usecase.dart';
import 'package:music_player/presentation/pages/main/main_state.dart';

class MainCubit extends Cubit<MainState> {
  final ISongsRepository _songsRepository;
  final UserUseCase _usersUseCase;

  MainCubit(
    this._songsRepository,
    this._usersUseCase,
  ) : super(
          const MainState(
            songs: [],
            loadingStatus: LoadingStatus.idle,
            goToSongPage: false,
            currentIndex: -1,
          ),
        );

  StreamSubscription? _songsSubscription;
  StreamSubscription? _userSubscription;

  void init() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    final currentId = await _usersUseCase.currentID;

    _songsSubscription?.cancel();
    _songsSubscription = _songsRepository.songs.listen((songs) {
      emit(
        state.copyWith(
          songs: songs
              .where((element) => element.userId == currentId)
              .toList(),
          loadingStatus: LoadingStatus.idle,
        ),
      );
    });

    _userSubscription?.cancel();
    _userSubscription = (await _usersUseCase.user).listen((user) {
      if (user.status == UserStatus.listener &&
          user.isSongPage &&
          !state.goToSongPage) {
        _usersUseCase.updateUser(isSongPage: true);
        emit(
          state.copyWith(
            goToSongPage: true,
            currentIndex: user.songParameter.indexCurrentSong,
          ),
        );
      }
    });
  }

  void updateSongs(List<SongModel> songs) => emit(state.copyWith(songs: songs));

  void resetTransition() => emit(
        state.copyWith(
          goToSongPage: false,
          currentIndex: -1,
        ),
      );
}
