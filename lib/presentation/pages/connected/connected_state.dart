import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/domain/model/user.dart';

class ConnectedState {
  final String connectedId;
  final List<User> users;
  final bool hasConnection;
  final List<SongModel> connectedSongs;

  ConnectedState({
    required this.connectedId,
    required this.users,
    required this.hasConnection,
    required this.connectedSongs,
  });

  ConnectedState copyWith({
    List<User>? users,
    String? connectedId,
    bool? hasConnection,
    List<SongModel>? connectedSongs,
  }) {
    return ConnectedState(
      users: users ?? this.users,
      hasConnection: hasConnection ?? this.hasConnection,
      connectedId: connectedId ?? this.connectedId,
      connectedSongs: connectedSongs ?? this.connectedSongs,
    );
  }
}
