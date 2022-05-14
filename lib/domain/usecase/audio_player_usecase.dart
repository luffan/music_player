import 'package:just_audio/just_audio.dart';
import 'package:music_player/domain/data_interface/i_audio_player_repository.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/model/enum/user_status.dart';
import 'package:music_player/domain/model/user.dart';

class AudioPlayerUseCase {
  final IAuthClient _authClient;
  final IUsersRepository _usersRepository;
  final IAudioPlayerRepository _audioPlayerRepository;

  const AudioPlayerUseCase(
    this._audioPlayerRepository,
    this._authClient,
    this._usersRepository,
  );

  Stream<Duration> get onDurationChange =>
      _audioPlayerRepository.onDurationChange;

  Stream<ProcessingState> get onPlayerCompletion =>
      _audioPlayerRepository.onPlayerCompletion;

  String get _currentID {
    final String userId;
    if (_authClient.currentUser.status == UserStatus.controller) {
      userId = _authClient.currentUser.connectedId;
    } else {
      userId = _authClient.currentUser.id;
    }
    return userId;
  }

  Future<User> get currentUser async => _usersRepository.getUser(_currentID);

  void pause() async {
    final user = await currentUser;
    if (user.status != UserStatus.controller) {
      _audioPlayerRepository.pause();
    }
  }

  void stop() async {
    final user = await currentUser;
    if (user.status != UserStatus.controller) {
      _audioPlayerRepository.stop();
    }
  }

  void resume() async {
    final user = await currentUser;
    if (user.status != UserStatus.controller) {
      _audioPlayerRepository.resume();
    }
  }

  void play(String uri) async {
    final user = await currentUser;
    if (user.status != UserStatus.controller) {
      _audioPlayerRepository.play(uri);
    }
  }

  void seek(Duration position) async {
    final user = await currentUser;
    if (user.status != UserStatus.controller) {
      _audioPlayerRepository.seek(position);
    }
  }
}
