import 'dart:async';

import 'package:nyxx/nyxx.dart';

import '../main.dart';

typedef OnMessageReceived = void Function(Message message);

class Commander implements Disposable {
  Commander(this._client, this._prefix);

  final Nyxx _client;
  final String _prefix;
  final Map<String, OnMessageReceived> _messageReceivedCommands = {};
  final List<StreamSubscription> _subscriptions = [];

  void listen() {
    final commandsSub = _client.onMessageReceived
        .where((event) =>
            !event.message.author.bot &&
            event.message.content.startsWith(_prefix))
        .listen((event) {
      final content = event.message.content;
      final command = content.substring(_prefix.length).split(r' ').first;
      _messageReceivedCommands[command]?.call(event.message);
    });
    _subscriptions.add(commandsSub);
  }

  void register(String name, OnMessageReceived onCommand) {
    assert(!_messageReceivedCommands.containsKey(name));
    final commandCallback = (Message message) {
      onCommand?.call(message);
      logger.d('User ${message.author} called command ${message.content}');
    };
    _messageReceivedCommands[name.removeAll(_prefix)] = commandCallback;
  }

  @override
  Future<void> dispose() {
    _messageReceivedCommands.clear();
    return Future.wait([
      _client.close(),
      for (var sub in _subscriptions) sub.cancel(),
    ]);
  }
}

extension on String {
  String removeAll(String toRemove) => replaceAll(toRemove, '');
}
