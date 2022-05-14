import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';
import 'package:music_player/domain/model/enum/loading_status.dart';
import 'package:music_player/domain/model/song_model.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/model/app_pages.dart';
import 'package:music_player/presentation/pages/song_page/song_page.dart';

import 'main_cubit.dart';
import 'main_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainCubit _cubit = locator<MainCubit>();

  void _goToSongPage(int index) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SongPage(
            startIndex: index,
            songs: _cubit.state.songs,
          ),
        ),
      );

  void _goToConnectedPage() => Navigator.of(context).pushNamed(
        AppPages.connected.name,
      );

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed(
              AppPages.connected.name,
            );
            _cubit.updateSongs(result as List<SongModel>);
          },
        ),
        title: const Text('Music player'),
      ),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: _cubit,
        builder: (context, state) {
          final songs = state.songs;

          if (state.loadingStatus == LoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (songs.isEmpty) {
            return const Center(child: Text('No songs'));
          }

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (_, int index) => _song(
              name: songs[index].name,
              info: songs[index].artist,
              onTap: () => _goToSongPage(index),
            ),
          );
        },
      ),
    );
  }

  Widget _song({
    required String name,
    required String info,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFFC30083),
        ),
        child: const Icon(
          Icons.music_note,
          color: Colors.white,
        ),
      ),
      title: Text(name),
      subtitle: Text(info),
    );
  }
}
