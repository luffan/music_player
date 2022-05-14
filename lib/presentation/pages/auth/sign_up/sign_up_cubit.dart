import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/usecase/auth_user_usecase.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final IAuthClient _authClient;
  final AuthUserUseCase _authUserUseCase;

  SignUpCubit(
    this._authClient,
    this._authUserUseCase,
  ) : super(
          SignUpState(
            name: '',
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

  Future<void> signUp() async {
    await _authClient.signUp(
      name: state.name,
      email: state.email,
      password: state.password,
    );
  }

  void updateName(String? name) => emit(
        state.copyWith(
          name: name?.trim() ?? '',
        ),
      );

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
