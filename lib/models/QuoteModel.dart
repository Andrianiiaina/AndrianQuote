import 'package:hive/hive.dart';
import 'quotyClass.dart';
export 'quotyClass.dart';
import 'sauvegarde.dart';

final box = Hive.box<QuotyClass>('quoty');

class QuoteModel {
  static getAllData() {
    return box.keys.map((e) {
      final value = box.get(e);
      return QuotyClass(
          id: e, author: value!.author, book: value.book, quote: value.quote);
    }).toList();
  }

  static Future deleteQuote(int id) async {
    await box.delete(id);
  }

  static getQuote(int id) {
    return box.get(id);
  }

  static addQuote(author, book, quote) async {
    await box.add(QuotyClass(
      author: author,
      book: book,
      quote: quote,
    ));
  }

  static updateQuote(
      int idQuote, String author, String book, String quoteE) async {
    await box.put(
        idQuote, QuotyClass(author: author, book: book, quote: quoteE));
  }

  static recupJsonDataQuote() async {
    final List<QuotyClass> quotes = await sauvegarde.majQuote();
    box.clear();
    box.addAll(quotes);
  }
}
