import 'package:music_player/domain/data_interface/i_local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _isSaveDate = 'isSaveDate';

class LocalStorageRepository implements ILocalStorageRepository {
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> getIsSaveDate() {
    return _prefs.then((prefs) => prefs.getBool(_isSaveDate) ?? false);
  }

  @override
  void setIsSaveDate(bool isSaveDate) {
    _prefs.then((prefs) => prefs.setBool(_isSaveDate, isSaveDate));
  }
}
