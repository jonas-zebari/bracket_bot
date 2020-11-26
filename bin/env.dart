import 'dart:io';

class Environment {
  static final Environment instance = Environment._();

  Environment._() {
    final env = File('../.env');
    final token = env.readAsStringSync().trim();
    _token = token;
  }

  String _token;
  String get token => _token;

  String get prefix => '!';
}
