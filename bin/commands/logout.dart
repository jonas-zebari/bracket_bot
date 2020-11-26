import 'package:nyxx/nyxx.dart';

void onLogout(MessageReceivedEvent event) {
  final botOwner = event.message.client.app.owner;
  final messageOwner = event.message.author;
  if (botOwner.id == messageOwner.id) {
    event.message.client.close();
  } else {
    event.message.channel.send(content: 'You are not the bot owner.');
  }
}
