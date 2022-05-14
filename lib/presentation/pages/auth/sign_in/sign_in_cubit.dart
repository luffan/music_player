import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/usecase/auth_user_usecase.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final IAuthClient _authClient;
  final AuthUserUseCase _authUserUseCase;

  SignInCubit(
    this._authClient,
    this._authUserUseCase,
  ) : super(
          SignInState(
            email: '',
            password: '',
            completed: false,
          ),
        );

  void init() {
    _authUserUseCase.init(() => emit(state.copyWith(completed: true)));
  }

  void dispose() {
    _authUserUseCase.dispose();
  }

  Future<void> signIn() async {
    await _authClient.signIn(
      email: state.email,
      password: state.password,
    );
  }

  void updateEmail(String? email) => emit(
        state.copyWith(
          email: email?.trim() ?? '',
        ),
      );

  void updatePassword(String? password) => emit(
        state.copyWith(
          password: password?.trim() ?? '',
        ),
      );
}
