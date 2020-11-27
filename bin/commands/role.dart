import 'package:nyxx/nyxx.dart';

import '../environment.dart';

void onRole(Message message) async {
  final prefixLength = Environment.instance.prefix.length;
  final roleSelected = message.content.substring(prefixLength).split(r' ')[1];
  final role = message.guild.roles.values
      .firstWhere((role) => role.name == roleSelected, orElse: () => null);
  if (role != null) {
    final member = await message.guild.getMember(message.author);
    await member.addRole(role);
    await message.reply(
      content: 'Your role has been set to `${role.name}`',
    );
  }
}
