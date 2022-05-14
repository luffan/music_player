import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/presentation/pages/connected/connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  final IUsersRepository _usersRepository;
  final IAuthClient _authClient;
  final ISongsRepository _songsRepository;

  ConnectedCubit(
    this._usersRepository,
    this._authClient,
    this._songsRepository,
  ) : super(
          ConnectedState(
            users: [],
            hasConnection: false,
            connectedId: '',
            connectedSongs: [],
          ),
        );

  StreamSubscription? _usersSubscription;

  Future<List<SongModel>> get songs async =>
      _songsRepository.getSongsById(state.connectedId);

  void init() {
    _usersSubscription?.cancel();
    _usersSubscription = _usersRepository.users.listen((users) {
      if (state.users.length != users.length) {
        emit(
          state.copyWith(
            users: users
                .where(
                  (element) => element.id != _authClient.currentUser.id,
                )
                .toList(),
          ),
        );
      }
    });
  }

  void onUserTap(String id) async {
    final listenerUser = await _usersRepository.getUser(id);
    final controllerUser = await _usersRepository.getUser(
      _authClient.currentUser.id,
    );

    _usersRepository.update(
      listenerUser.copyWith(
        connectedId: controllerUser.id,
        status: UserStatus.listener,
      ),
    );

    _usersRepository.update(
      controllerUser.copyWith(
        connectedId: listenerUser.id,
        status: UserStatus.controller,
      ),
    );

    final songs = await _songsRepository.getSongsById(id);

    emit(
      state.copyWith(
        hasConnection: true,
        connectedId: id,
        connectedSongs: songs
      ),
    );
  }

  void connectedOut() async {
    final listenerUser = await _usersRepository.getUser(state.connectedId);
    final controllerUser = await _usersRepository.getUser(
      _authClient.currentUser.id,
    );

    _usersRepository.update(
      listenerUser.copyWith(
        connectedId: '',
        status: UserStatus.none,
      ),
    );

    _usersRepository.update(
      controllerUser.copyWith(
        connectedId: '',
        status: UserStatus.none,
      ),
    );

    emit(
      state.copyWith(
        hasConnection: false,
        connectedId: '',
      ),
    );
  }
}
