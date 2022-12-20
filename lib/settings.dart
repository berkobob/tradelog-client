class Settings {
  static String address = 'itx';
  static int port = 8888;

  static String get root => 'http://$address:$port';
}
