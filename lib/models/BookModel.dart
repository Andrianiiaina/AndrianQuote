import 'package:hive/hive.dart';
import 'bookClass.dart';
export 'bookClass.dart';

final box = Hive.box<BookClass>('book');

class BookModel {
  static final List<Map<String, dynamic>> bookCategory = [
    {'value': 'Thriller', 'label': 'Thriller'},
    {'value': 'Romance', 'label': 'Romance'},
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Dev perso', 'label': 'Dev perso'}
  ];
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
          isFinished: book.isFinished);
    }).toList();
  }

  static Future deleteBook(int id) async {
    await box.delete(id);
  }

//utiliser sur pile à lire pour le reordablelist
  static updateBookList(books, oldIndex, newIndex) async {
    books.removeAt(oldIndex);
    books.insert(newIndex, box.getAt(oldIndex)!);
    await box.clear();
    await box.addAll(books);
  }

  static getBook(int id) {
    return box.get(id);
  }

  static getBookAt(int id) {
    return box.getAt(id);
  }

  static addBook(BookClass values) async {
    await box.add(values);
  }
}
