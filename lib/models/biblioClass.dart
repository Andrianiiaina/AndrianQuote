import 'package:hive/hive.dart';

part 'biblioClass.g.dart';

@HiveType(typeId: 4)
class BiblioClass extends HiveObject {
  dynamic id;

  @HiveField(0)
  String filepath;
  @HiveField(1)
  String imagepath;
  @HiveField(2)
  int currentPage;
  @HiveField(3)
  int nbrPage;

  BiblioClass({
    this.id,
    required this.filepath,
    required this.imagepath,
    required this.currentPage,
    required this.nbrPage,
  });
}
