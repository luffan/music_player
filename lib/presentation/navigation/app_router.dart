import 'package:flutter/material.dart';
import 'package:music_player/presentation/model/app_pages.dart';
import 'package:music_player/presentation/pages/app/app_page.dart';
import 'package:music_player/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:music_player/presentation/pages/auth/sign_up/sign_up_page.dart';
import 'package:music_player/presentation/pages/connected/connected_page.dart';
import 'package:music_player/presentation/pages/main/main_page.dart';
import 'package:music_player/presentation/pages/profile/profile_page.dart';
import 'package:music_player/presentation/pages/search/search_page.dart';
import 'package:music_player/presentation/pages/song_page/song_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (AppPagesExt.getByName(settings.name)) {
      case AppPages.app:
        return MaterialPageRoute(
          builder: (_) => AppPage(),
        );
      case AppPages.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );
      case AppPages.main:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
      case AppPages.song:
        final int startIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => SongPage(
            startIndex: startIndex,
            songs: [],
          ),
        );
      case AppPages.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
        );
      case AppPages.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case AppPages.connected:
        return MaterialPageRoute(
          builder: (_) => const ConnectedPage(),
        );
      case AppPages.search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => AppPage(),
        );
    }
  }
}
