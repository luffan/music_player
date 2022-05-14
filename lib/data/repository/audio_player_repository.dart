import 'package:just_audio/just_audio.dart';
import 'package:music_player/domain/data_interface/i_audio_player_repository.dart';

class AudioPlayerRepository implements IAudioPlayerRepository {
  final _audioPlayer = AudioPlayer();

  @override
  Stream<Duration> get onDurationChange => _audioPlayer.positionStream;

  @override
  Stream<ProcessingState> get onPlayerCompletion => _audioPlayer.processingStateStream;

  @override
  void pause() => _audioPlayer.pause();

  @override
  void play(String uri) {
    _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
    _audioPlayer.play();
  }

  @override
  void resume() => _audioPlayer.play();

  @override
  void stop() => _audioPlayer.stop();

  @override
  void seek(Duration position) => _audioPlayer.seek(position);
}
