import 'package:hive/hive.dart';

part 'quoteClass.g.dart';

@HiveType(typeId: 0)
class QuoteClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String author;
  @HiveField(1)
  String book;
  @HiveField(2)
  String quote;

  QuoteClass({
    this.id,
    required this.author,
    required this.book,
    required this.quote,
  });
}
