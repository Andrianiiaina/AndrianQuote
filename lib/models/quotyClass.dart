import 'package:hive/hive.dart';

part 'quotyClass.g.dart';

@HiveType(typeId: 0)
class QuotyClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String author;
  @HiveField(1)
  String book;
  @HiveField(2)
  String quote;

  QuotyClass({
    this.id,
    required this.author,
    required this.book,
    required this.quote,
  });
}
