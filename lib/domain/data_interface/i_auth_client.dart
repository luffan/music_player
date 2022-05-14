import 'package:music_player/domain/model/user.dart';

abstract class IAuthClient {
  User get currentUser;

  Stream<User> get userChanges;

  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  });

  void signOut();
}
