import 'package:hive/hive.dart';
part 'wishlistClass.g.dart';

@HiveType(typeId: 3)
class WishlistClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  String title;
  @HiveField(1)
  String author;
  @HiveField(2)
  String version;
  @HiveField(3)
  String priority;
  @HiveField(4)
  String resume;
  @HiveField(6)
  String category;
  @HiveField(8)
  String nbrPage;

  WishlistClass({
    this.id,
    required this.title,
    required this.author,
    required this.version,
    required this.priority,
    required this.resume,
    required this.category,
    required this.nbrPage,
  });
}
