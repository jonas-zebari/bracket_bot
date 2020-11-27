import 'package:nyxx/nyxx.dart';

void onPing(Message message) {
  message.channel.send(content: 'Pong!');
}
