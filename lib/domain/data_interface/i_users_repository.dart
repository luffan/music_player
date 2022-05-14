import 'package:music_player/domain/model/user.dart';

abstract class IUsersRepository {
  Stream<List<User>> get users;

  void add(User user);
  void update(User user);

  Future<User> getUser(String id);
}
