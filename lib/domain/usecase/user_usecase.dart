import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/song_parameter.dart';
import 'package:music_player/domain/model/user.dart';

class UserUseCase {
  final IAuthClient _authClient;
  final IUsersRepository _usersRepository;

  const UserUseCase(
    this._authClient,
    this._usersRepository,
  );

  Future<String> get currentID async {
    final user = await _usersRepository.getUser(_authClient.currentUser.id);
    final String userId;
    if (user.status == UserStatus.controller) {
      userId = user.connectedId;
    } else {
      userId = user.id;
    }
    return userId;
  }

  Future<Stream<User>> get user async {
    final currentId = await currentID;
    return _usersRepository.users.map<User>(
      (users) => users
          .where(
            (element) => element.id == currentId,
          )
          .first,
    );
  }

  void updateUser({
    UserStatus? status,
    SongParameter? songParameter,
    bool? isSongPage,
  }) async {
    final currentId = await currentID;
    final user = await _usersRepository.getUser(currentId);
    if (user.status != UserStatus.listener) {
      _usersRepository.update(
        user.copyWith(
          status: status,
          songParameter: songParameter,
          isSongPage: isSongPage,
        ),
      );
    }
  }
}
