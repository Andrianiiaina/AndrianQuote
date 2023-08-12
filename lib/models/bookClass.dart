import 'package:hive/hive.dart';
part 'bookClass.g.dart';

@HiveType(typeId: 2)
class BookClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String title;
  @HiveField(1)
  String author;
  @HiveField(2)
  String version;
  @HiveField(3)
  String note;
  @HiveField(4)
  String resume;
  @HiveField(5)
  String category;
  @HiveField(6)
  String couverture;
  @HiveField(7)
  String nbrPage;
  @HiveField(8)
  DateTime date;
  @HiveField(9)
  String status;

  BookClass(
      {this.id,
      required this.title,
      required this.author,
      required this.version,
      required this.note,
      required this.resume,
      required this.category,
      required this.couverture,
      required this.nbrPage,
      required this.date,
      required this.status});
}
