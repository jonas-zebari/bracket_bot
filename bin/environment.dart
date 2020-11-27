import 'dart:io';

import 'main.dart';

class Environment {
  static final Environment instance = Environment._();

  Environment._() {
    final env = File('.env');
    if (env.existsSync()) {
      final token = env.readAsStringSync().trim();
      _token = token;
    } else {
      logger.e('No .env file was found in repository root');
      exit(1);
    }
  }

  final String prefix = '!';

  String _token;
  String get token => _token;
}
