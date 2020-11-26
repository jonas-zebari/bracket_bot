import 'package:nyxx/nyxx.dart';

void onPing(MessageReceivedEvent event) {
  event.message.channel.send(content: 'Pong!');
}
