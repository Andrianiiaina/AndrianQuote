import 'package:hive/hive.dart';
import 'authorClass.dart';
export 'authorClass.dart';

final box = Hive.box<AuthorClass>('author');

class AuthorModel {
  static getAllData() {
    return box.keys.map((e) {
      final aut = box.get(e);
      return AuthorClass(
          id: e,
          author: aut!.author,
          biography: aut.biography,
          books: aut.books,
          profile: aut.profile);
    }).toList();
  }

  static Future deleteAuthor(int id) async {
    await box.delete(id);
  }

  static getAuthor(int id) {
    return box.get(id);
  }

  static addAuthor(AuthorClass values) async {
    await box.add(values);
  }
  /**
  *  static updateAuthor(
      int idAuthor, String author, String book, String authorE) async {
    await box.put(
        idAuthor, AuthorClass(author: author, book: book, author: authorE));
  }
  */
}
