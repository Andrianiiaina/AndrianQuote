import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'quotyClass.dart';
import 'dart:convert';
import 'dart:io';
import 'bookClass.dart';

final boxQuote = Hive.box<QuotyClass>('quoty');
final boxBook = Hive.box<BookClass>('book');

// ignore: camel_case_types
class sauvegarde {
  static exportToJson() async {
    List<Map<String, dynamic>> dataQuote = boxQuote.keys.map((e) {
      final value = boxQuote.get(e);
      Map<String, dynamic> mapData = {
        'id': e,
        'author': value!.author,
        'book': value.book,
        'quote': value.quote
      };
      return mapData;
    }).toList();

    List<Map<String, dynamic>> dataBook = boxBook.keys.map((e) {
      final value = boxBook.get(e);
      Map<String, dynamic> mapData = {
        'id': e,
        'author': value!.author,
        'title': value.title,
        'version': value.version,
        'note': value.note,
        'resume': value.resume,
        'isFinished': value.isFinished,
        'category': value.category,
        'couverture': value.couverture,
        'nbrPage': value.nbrPage,
        'isbn': value.isbn,
      };
      return mapData;
    }).toList();

    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    File fileQuote = File('$appDirPath/fileBook.json');
    File fileBook = File('$appDirPath/fileQuote.json');
    String jsonDataQuote = json.encode(dataQuote);
    String jsonDataBook = json.encode(dataBook);
    await fileQuote.writeAsString(jsonDataQuote);
    await fileBook.writeAsString(jsonDataBook);
  }

  static majQuote() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String filePathQuote = '$appDirPath/fileQuote.json';
    String jsonStringQuote = await File(filePathQuote).readAsString();

    List<dynamic> jsonDataQuote = json.decode(jsonStringQuote);

    return jsonDataQuote.map((data) {
      return QuotyClass(
        id: data["id"],
        book: data["book"],
        author: data["author"],
        quote: data["quote"],
      );
    }).toList();
  }

  static majBook() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String filePathBook = '$appDirPath/fileBook.json';
    String jsonStringBook = await File(filePathBook).readAsString();

    List<dynamic> jsonDataBook = json.decode(jsonStringBook);

    return jsonDataBook.map((data) {
      return BookClass(
        id: data["id"],
        title: data["book"],
        author: data["author"],
        version: data["version"],
        note: data["note"],
        resume: data["resume"],
        isFinished: data["isFinished"],
        category: data["category"],
        couverture: data["couverture"],
        nbrPage: data["nbrPage"],
        isbn: data["isbn"],
      );
    }).toList();
  }
}
