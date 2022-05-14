import 'package:just_audio/just_audio.dart';

abstract class IAudioPlayerRepository {
  Stream<Duration> get onDurationChange;
  Stream<ProcessingState> get onPlayerCompletion;

  void pause();

  void stop();

  void resume();

  void play(String uri);

  void seek(Duration position);
}
