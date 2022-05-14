import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final IAuthClient _authClient;

  AppCubit(this._authClient)
      : super(
          const AppState(
            hasUser: false,
          ),
        );

  void checkUserStatus() => emit(
        state.copyWith(
          hasUser: !_authClient.currentUser.isNotActive,
        ),
      );
}
