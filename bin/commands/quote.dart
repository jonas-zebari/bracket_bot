import 'dart:math';

import 'package:hive/hive.dart';
import 'package:nyxx/nyxx.dart';

import '../database/quote.dart';

void onQuote(Message message) async {
  final args = message.content.args;
  final quotedUserId = args[1].idFromMention;
  final quoteContent = args.skip(2).join(' ');

  final quoteBox = await Hive.quoteBox(quotedUserId);
  final quote = Quote(
    content: quoteContent,
    author: quotedUserId,
    quotedBy: message.author.id.toString(),
    timestamp: DateTime.now(),
  );
  await quoteBox.add(quote);
  await message.reply(
    content: 'quoted ${args[1]} as saying `${quote.content}`.',
  );

  await quoteBox.compactAndClose();
}

void onGetQuote(Message message) async {
  final args = message.content.args;
  final quotedUserId = args[1].idFromMention;
  final quoteBox = await Hive.quoteBox(quotedUserId);

  final randomKeyIndex = Random().nextInt(quoteBox.length);
  final randomQuote = await quoteBox.getAt(randomKeyIndex);
  await message.reply(
    content: 'On ${randomQuote.timestamp}, ${args[1]} '
        'said: `${randomQuote.content}`.',
  );

  await quoteBox.compactAndClose();
}

void onClearQuotes(Message message) async {
  final quoteBox = await Hive.quoteBox(message.author.id.toString());
  await quoteBox.clear();
  await message.reply(content: 'Quotes cleared.');
  await quoteBox.compactAndClose();
}

/// EXTENSIONS
extension on HiveInterface {
  Future<LazyBox<Quote>> quoteBox(String userId) =>
      Hive.openLazyBox<Quote>('quote#$userId');
}

extension on LazyBox<Quote> {
  Future<void> compactAndClose() async {
    await compact();
    await close();
  }
}

extension on String {
  List<String> get args => trim().split(RegExp(r'\s+'));

  String get idFromMention => replaceAll(RegExp(r'[<>@!]'), '');
}
