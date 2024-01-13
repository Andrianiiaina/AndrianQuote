import 'biblio_class.dart';
import 'package:hive/hive.dart';
export 'biblio_class.dart';

final box = Hive.box<BiblioClass>('biblio');

class BiblioModel {
  static getBiblios() {
    if (box.values.isEmpty) return [];
    return box.keys.take(6).map((e) {
      final value = box.get(e);
      return BiblioClass(
        id: e,
        filepath: value!.filepath,
        imagepath: value.imagepath,
        currentPage: value.currentPage,
        nbrPage: value.nbrPage,
      );
    }).toList();
  }

  static Future deleteBiblio(int id) async {
    await box.delete(id);
  }

  static getBiblio(int id) {
    return box.get(id);
  }

  static addBiblio(BiblioClass biblio) async {
    await box.add(biblio);
  }

  static putBiblio(int index, BiblioClass biblio) async {
    await box.put(index, biblio);
  }
}
