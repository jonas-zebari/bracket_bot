import 'package:hive/hive.dart';

part 'quote.g.dart';

@HiveType(typeId: 0)
class Quote {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String quotedBy;

  Quote({this.content, this.timestamp, this.author, this.quotedBy});
}
