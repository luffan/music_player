import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/model/user.dart' as app;

class AuthClient implements IAuthClient {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  app.User get currentUser => app.User.fromFirebase(_auth.currentUser);

  @override
  Stream<app.User> get userChanges =>
      _auth.userChanges().map((user) => app.User.fromFirebase(user));

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      return user.uid;
    }

    return '';
  }

  @override
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      user.updateDisplayName(name);
      return user.uid;
    }

    return '';
  }

  @override
  void signOut() => _auth.signOut();
}
