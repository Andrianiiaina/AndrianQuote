import 'package:hive/hive.dart';

part 'quoty_class.g.dart';

@HiveType(typeId: 0)
class QuotyClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String author;
  @HiveField(1)
  String book;
  @HiveField(2)
  String quote;
  @HiveField(3)
  String fond;

  QuotyClass({
    this.id,
    required this.author,
    required this.book,
    required this.quote,
    required this.fond,
  });
}
