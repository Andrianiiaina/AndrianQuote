import 'package:hive/hive.dart';
import 'bookClass.dart';
export 'bookClass.dart';

final box = Hive.box<BookClass>('book');

class BookModel {
  static final List<Map<String, dynamic>> bookCategory = [
    {'value': 'all', 'label': 'All'},
    {'value': 'Jeunes adultes', 'label': 'Jeunes adultes'},
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Essais et documents', 'label': 'Essais et documents'},
    {'value': 'Biographie', 'label': 'Biographie'},
    {'value': 'Jeunesse', 'label': 'Jeunesse'},
    {'value': 'Littérature et fiction', 'label': 'Littérature et fiction'},
    {'value': 'Littérature sentimentale', 'label': 'Littérature sentimentale'},
    {'value': 'Policier et thriller', 'label': 'Policier et thriller'},
    {'value': 'SF et Fantasy', 'label': 'SF et Fantasy'},
    {'value': 'BD et mangas', 'label': 'BD et mangas'},
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
          isFinished: book.isFinished,
          couverture: book.couverture,
          nbrPage: book.nbrPage,
          isbn: book.isbn);
    }).toList();
  }

  static Future deleteBook(int id) async {
    await box.delete(id);
  }

//utiliser sur pile à lire pour le reordablelist
  static updateBookList(books, oldIndex, newIndex) async {
    await books.removeAt(oldIndex);
    await books.insert(newIndex, box.getAt(oldIndex)!);
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

  static updateBook(idBook, BookClass values) async {
    await box.put(idBook, values);
  }
}
