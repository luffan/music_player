import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/model/user.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/pages/connected/connected_cubit.dart';
import 'package:music_player/presentation/pages/connected/connected_state.dart';
import 'package:music_player/presentation/widget/app_button.dart';

class ConnectedPage extends StatefulWidget {
  const ConnectedPage({Key? key}) : super(key: key);

  @override
  State<ConnectedPage> createState() => _ConnectedPageState();
}

class _ConnectedPageState extends State<ConnectedPage> {
  final _cubit = locator<ConnectedCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectedCubit, ConnectedState>(
      bloc: _cubit,
      listener: (context, state) async {
        Navigator.pop(context, state.connectedSongs);
      },
      listenWhen: (prev, cur) => !prev.hasConnection && cur.hasConnection,
      builder: (context, state) {
        final mainWidget = state.hasConnection
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                child: AppButton(
                  text: 'Connected out',
                  onTap: _cubit.connectedOut,
                ),
              )
            : ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => _user(
                  state.users[index],
                ),
              );
        return Scaffold(
          appBar: AppBar(
            title: const Text('Connected'),
          ),
          body: Center(child: mainWidget),
        );
      },
    );
  }

  Widget _user(User user) {
    return ListTile(
      onTap: () => _cubit.onUserTap(user.id),
      title: Text(user.email),
      subtitle: Text(user.id),
    );
  }
}
