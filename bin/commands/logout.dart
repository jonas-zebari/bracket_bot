import 'package:nyxx/nyxx.dart';

void onLogout(Message message) {
  final botOwner = message.client.app.owner;
  final messageOwner = message.author;
  if (botOwner.id == messageOwner.id) {
    message.client.close();
  } else {
    message.channel.send(content: 'You are not the bot owner.');
  }
}
