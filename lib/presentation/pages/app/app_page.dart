import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/navigation/app_router.dart';
import 'package:music_player/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:music_player/presentation/pages/main/main_page.dart';

import 'app_cubit.dart';
import 'app_state.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final AppCubit _cubit = locator<AppCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      bloc: _cubit,
      builder: (context, state) => MaterialApp(
        onGenerateRoute: AppRouter().onGenerateRoute,
        home: state.hasUser ? const MainPage() : const SignInPage(),
      ),
    );
  }
}
