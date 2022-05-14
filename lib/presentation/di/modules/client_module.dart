import 'package:music_player/data/clients/auth_client.dart';
import 'package:music_player/domain/data_interface/i_auth_client.dart';

import '../locator.dart';
import 'i_register_interface.dart';

class ClientModule implements IRegisterInterface {
  @override
  Future<void> registerDependencies() async {
    locator.registerSingleton<IAuthClient>(
      AuthClient(),
    );
  }
}
