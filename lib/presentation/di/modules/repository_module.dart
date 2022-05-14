import 'package:music_player/data/repository/audio_player_repository.dart';
import 'package:music_player/data/repository/internal_storage_repository.dart';
import 'package:music_player/data/repository/local_storage_repository.dart';
import 'package:music_player/data/repository/songs_repository.dart';
import 'package:music_player/data/repository/users_repository.dart';
import 'package:music_player/domain/data_interface/I_internal_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_audio_player_repository.dart';
import 'package:music_player/domain/data_interface/i_local_storage_repository.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/presentation/di/locator.dart';

import 'i_register_interface.dart';

class RepositoryModule implements IRegisterInterface {
  @override
  Future<void> registerDependencies() async {
    locator.registerSingleton<IAudioPlayerRepository>(
      AudioPlayerRepository(),
    );

    locator.registerSingleton<IInternalStorageRepository>(
      InternalStorageRepository(),
    );

    locator.registerSingleton<ISongsRepository>(
      SongsRepository(),
    );

    locator.registerSingleton<IUsersRepository>(
      UsersRepository(),
    );

    locator.registerSingleton<ILocalStorageRepository>(
      LocalStorageRepository(),
    );
  }
}
