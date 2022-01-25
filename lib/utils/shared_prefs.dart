import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get data => _sharedPrefs.getString('data') ?? '';
  String get currentData => _sharedPrefs.getString('currentData') ?? '';

  set data(String value) {
    _sharedPrefs.setString('data', value);
  }

  set currentData(String value) {
    _sharedPrefs.setString('currentData', value);
  }
}

final sharedPrefs = SharedPrefs();
