import 'package:nyxx/nyxx.dart';

import '../env.dart' as env;

void onRole(MessageReceivedEvent event) async {
  final roleSelected =
      event.message.content.substring(env.prefix.length).split(r' ')[1];
  final role =
      event.message.guild.roles.findOne((role) => role.name == roleSelected);
  if (role != null) {
    final member = await event.message.guild.getMember(event.message.author);
    await member.addRole(role);
    await event.message.reply(
      content: 'Your role has been set to `${role.name}`',
    );
  }
}
