import 'package:hive/hive.dart';
part 'wishlist_class.g.dart';

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
  String resume;
  @HiveField(4)
  String category;
  @HiveField(5)
  String nbrPage;

  WishlistClass({
    this.id,
    required this.title,
    required this.author,
    required this.version,
    required this.resume,
    required this.category,
    required this.nbrPage,
  });
}
