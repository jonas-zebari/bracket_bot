import 'dart:io';

import 'package:hive/hive.dart';
import 'package:nyxx/Vm.dart';
import 'package:nyxx/nyxx.dart';

import 'commands/commands.dart';
import 'database/quote.dart';
import 'env.dart' as env;

void main() {
  initDatabase();
  initDiscord();
}

void initDatabase() {
  final path = Directory.current.path;
  Hive.init(path);
  Hive.registerAdapter(QuoteAdapter());
}

void initDiscord() {
  configureNyxxForVM();
  final client = Nyxx(env.token); // Nyxx => discord.Client
  final commands = Commander(client, env.prefix);
  commands.register('ping', onPing);
  commands.register('logout', onLogout);
  commands.register('role', onRole);
  commands.register('quote', onQuote);
  commands.listen();
}
