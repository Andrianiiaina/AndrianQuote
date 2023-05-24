import 'package:hive/hive.dart';
part 'authorClass.g.dart';

@HiveType(typeId: 1)
class AuthorClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String author;
  @HiveField(1)
  String biography;
  @HiveField(2)
  List<String> books;
  @HiveField(3)
  String profile;
  AuthorClass(
      {this.id,
      required this.author,
      required this.biography,
      required this.books,
      required this.profile});
}
