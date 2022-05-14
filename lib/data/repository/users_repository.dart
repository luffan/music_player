import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/domain/model/user.dart';
import 'package:music_player/domain/data_interface/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<User>> get users => _usersCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
      });

  @override
  void add(User song) {
    _usersCollection.add(song.toDocument());
  }

  @override
  void update(User user) {
    _usersCollection.doc(user.snapId).update(user.toDocument());
  }

  @override
  Future<User> getUser(String id) async {
    final snapshot = await _usersCollection.get();
    return snapshot.docs
        .map((doc) => User.fromSnapshot(doc))
        .where((user) => user.id == id)
        .first;
  }
}
