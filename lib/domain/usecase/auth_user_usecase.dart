import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/usecase/song_usecase.dart';

class AuthUserUseCase {
  final IAuthClient _authClient;
  final SongUseCase _songUseCase;
  final IUsersRepository _usersRepository;

  AuthUserUseCase(
    this._authClient,
    this._songUseCase,
    this._usersRepository,
  );

  StreamSubscription? _authUserSubscription;
  bool _initialize = false;

  void init(VoidCallback callback) {
    _authUserSubscription?.cancel();
    _authUserSubscription = _authClient.userChanges.listen((user) {
      if (!user.isNotActive && !_initialize) {
        _initialize = true;

        _songUseCase.loadSongs(user.id);

        _usersRepository.add(user);

        callback.call();
      }
    });
  }

  void dispose() {
    _authUserSubscription?.cancel();
  }
}
