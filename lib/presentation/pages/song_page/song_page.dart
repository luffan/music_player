import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/pages/song_page/song_cubit.dart';
import 'package:music_player/presentation/pages/song_page/song_state.dart';
import 'package:music_player/presentation/utils/extension/play_back_option_song_ext.dart';

class SongPage extends StatefulWidget {
  final int startIndex;
  final List<SongModel> songs;

  const SongPage({
    Key? key,
    required this.startIndex,
    required this.songs,
  }) : super(key: key);

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _cubit = locator<SongCubit>();

  void _goBack() {
    _cubit.resetTransition();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _cubit.init();
    _cubit.startPlaying(
      widget.startIndex,
      widget.songs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongCubit, SongState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.songs.isEmpty) return const CircularProgressIndicator();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: _goBack,
            ),
            elevation: 0,
            backgroundColor: const Color(0xFF3A0470),
            title: Text(state.currentSong.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC30083),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state.currentTime.toString().split('.')[0]),
                      Text(Duration(milliseconds: state.currentSong.duration)
                          .toString()
                          .split('.')[0]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: _slider(state),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _cubit.changeSongStatus(),
                        icon: Icon(state.option.icon),
                      ),
                      IconButton(
                        onPressed: () => _cubit.playPrevious(),
                        icon: const Icon(Icons.skip_previous),
                      ),
                      IconButton(
                        onPressed: () => _cubit.onControllCircleTap(),
                        icon: Icon(
                          state.isPlaying ? Icons.play_circle : Icons.pause,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _cubit.playNext(),
                        icon: const Icon(Icons.skip_next),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.queue_music),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _slider(SongState state) {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: state.currentTime.inSeconds.toDouble(),
      min: 0.0,
      max: Duration(milliseconds: state.currentSong.duration)
          .inSeconds
          .toDouble(),
      onChanged: (_) {},
      onChangeEnd: (value) => _cubit.positionChanged(value.toInt()),
    );
  }
}
