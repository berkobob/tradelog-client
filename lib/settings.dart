import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static String _address = 'itx';
  static int _port = 8888;
  late final SharedPreferences prefs;

  Future<Settings> init() async {
    prefs = await SharedPreferences.getInstance();
    Settings._address = prefs.getString('address') ?? 'itx';
    Settings._port = prefs.getInt('port') ?? 8888;
    return this;
  }

  static String get root => 'http://$_address:$_port';
  String get address => _address;
  int get port => _port;

  set address(String update) {
    _address = update;
    prefs.setString('address', _address);
  }

  set port(int update) {
    _port = port;
    prefs.setInt('port', _port);
  }
}
