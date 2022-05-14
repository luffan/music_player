import 'package:music_player/domain/data_interface/I_internal_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_audio_player_repository.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_local_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/usecase/audio_player_usecase.dart';
import 'package:music_player/domain/usecase/auth_user_usecase.dart';
import 'package:music_player/domain/usecase/song_usecase.dart';
import 'package:music_player/domain/usecase/user_usecase.dart';

import '../locator.dart';
import 'i_register_interface.dart';

class UseCaseModule implements IRegisterInterface {
  @override
  Future<void> registerDependencies() async {
    locator.registerSingleton<SongUseCase>(
      SongUseCase(
        locator<ILocalStorageRepository>(),
        locator<ISongsRepository>(),
        locator<IInternalStorageRepository>(),
      ),
    );
    locator.registerSingleton<AuthUserUseCase>(
      AuthUserUseCase(
        locator<IAuthClient>(),
        locator<SongUseCase>(),
        locator<IUsersRepository>(),
      ),
    );
    locator.registerSingleton<UserUseCase>(
      UserUseCase(
        locator<IAuthClient>(),
        locator<IUsersRepository>(),
      ),
    );
    locator.registerSingleton<AudioPlayerUseCase>(
      AudioPlayerUseCase(
        locator<IAudioPlayerRepository>(),
        locator<IAuthClient>(),
        locator<IUsersRepository>(),
      ),
    );
  }
}
