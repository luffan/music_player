import 'package:music_player/domain/data_interface/i_audio_player_repository.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/data_interface/i_songs_repository.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';
import 'package:music_player/domain/usecase/audio_player_usecase.dart';
import 'package:music_player/domain/usecase/auth_user_usecase.dart';
import 'package:music_player/domain/usecase/song_usecase.dart';
import 'package:music_player/domain/usecase/user_usecase.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/pages/app/app_cubit.dart';
import 'package:music_player/presentation/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:music_player/presentation/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:music_player/presentation/pages/connected/connected_cubit.dart';
import 'package:music_player/presentation/pages/main/main_cubit.dart';
import 'package:music_player/presentation/pages/song_page/song_cubit.dart';

import 'i_register_interface.dart';

class CubitModule implements IRegisterInterface {
  @override
  Future<void> registerDependencies() async {
    locator.registerSingleton<AppCubit>(
      AppCubit(
        locator<IAuthClient>(),
      ),
    );
    locator.registerSingleton<MainCubit>(
      MainCubit(
        locator<ISongsRepository>(),
        locator<UserUseCase>(),
      ),
    );

    locator.registerSingleton<SongCubit>(
      SongCubit(
        locator<AudioPlayerUseCase>(),
        locator<UserUseCase>(),
      ),
    );

    locator.registerSingleton<SignInCubit>(
      SignInCubit(
        locator<IAuthClient>(),
        locator<AuthUserUseCase>(),
      ),
    );
    locator.registerSingleton<SignUpCubit>(
      SignUpCubit(
        locator<IAuthClient>(),
        locator<AuthUserUseCase>(),
      ),
    );
    locator.registerSingleton<ConnectedCubit>(
      ConnectedCubit(
        locator<IUsersRepository>(),
        locator<IAuthClient>(),
        locator<ISongsRepository>(),
      ),
    );
  }
}
