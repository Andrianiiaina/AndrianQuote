import 'package:andrianiaiina_quote/models/sauvegarde.dart';
import 'package:hive/hive.dart';
import 'book_class.dart';
export 'book_class.dart';

final box = Hive.box<BookClass>('book');

class BookModel {
  static getAllData() {
    return box.keys.map((e) {
      final book = box.get(e);

      return BookClass(
        id: e,
        author: book!.author,
        title: book.title,
        version: book.version,
        category: book.category,
        note: book.note.toString(),
        resume: book.resume,
        couverture: book.couverture,
        nbrPage: book.nbrPage,
        date: book.date,
        status: book.status,
        isPaper: book.isPaper,
        debut: book.debut,
      );
    }).toList();
  }

  static Future deleteBook(int id) async {
    await box.delete(id);
  }

  static getBook(int id) {
    return box.get(id);
  }

  static addBook(BookClass values) async {
    await box.add(values);
  }

  static updateBook(idBook, BookClass values) async {
    await box.put(idBook, values);
  }

  static recupJsonDataBook() async {
    final List<BookClass> books = await sauvegarde.majBook();
    box.clear();
    box.addAll(books);
  }
}
