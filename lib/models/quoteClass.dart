import 'package:hive/hive.dart';

part 'quoteClass.g.dart';

@HiveType(typeId: 0)
class QuoteClass extends HiveObject {
  dynamic key;
  @HiveField(0)
  int idBook;
  @HiveField(1)
  String quote;

  QuoteClass({
    this.key,
    required this.idBook,
    required this.quote,
  });
}
