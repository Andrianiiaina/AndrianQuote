import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'quotyClass.dart';
import 'dart:convert';
import 'dart:io';
import 'bookClass.dart';
import 'wishlistClass.dart';
import 'dart:math';

final boxQuote = Hive.box<QuotyClass>('quoty');
final boxBook = Hive.box<BookClass>('book');
final boxWishlist = Hive.box<WishlistClass>('wishlist');

// ignore: camel_case_types
class sauvegarde {
  static exportToJson() async {
    List<Map<String, dynamic>> dataQuote = boxQuote.keys.map((e) {
      final value = boxQuote.get(e);
      Map<String, dynamic> mapData = {
        'id': e,
        'author': value!.author,
        'book': value.book,
        'quote': value.quote,
        'fond': value.fond,
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
        'category': value.category,
        'couverture': value.couverture,
        'nbrPage': value.nbrPage,
        'date': value.date.toString(),
        'status': value.status,
      };
      return mapData;
    }).toList();
    List<Map<String, dynamic>> dataWishlist = boxWishlist.keys.map((e) {
      final value = boxWishlist.get(e);
      Map<String, dynamic> mapData = {
        'id': e,
        'author': value!.author,
        'title': value.title,
        'version': value.version,
        'resume': value.resume,
        'category': value.category,
        'nbrPage': value.nbrPage,
      };
      return mapData;
    }).toList();
    //Directory appDir = await getApplicationDocumentsDirectory();
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    File fileQuote = File('$appDirPath/fileQuoteJson.json');
    File fileBook = File('$appDirPath/fileBookJson.json');
    File fileWishlist = File('$appDirPath/fileWishlistJson.json');

    String jsonDataQuote = json.encode(dataQuote);
    String jsonDataBook = json.encode(dataBook);
    String jsonDataWishlist = json.encode(dataWishlist);

    await fileQuote.writeAsString(jsonDataQuote);
    await fileBook.writeAsString(jsonDataBook);
    await fileWishlist.writeAsString(jsonDataWishlist);
  }

  static majQuote() async {
    // Directory appDir = await getApplicationDocumentsDirectory();
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    String filePathQuote = '$appDirPath/fileQuoteJson.json';

    String jsonStringQuote = await File(filePathQuote).readAsString();

    List<dynamic> jsonDataQuote = json.decode(jsonStringQuote);

    return jsonDataQuote.map((data) {
      return QuotyClass(
          id: data["id"],
          book: data["book"],
          author: data["author"],
          quote: data["quote"],
          fond: data["fond"]);
      // fond: 'assets/p (${Random().nextInt(36) + 1}).jpg');
    }).toList();
  }

  static majBook() async {
    // Directory appDir = await getApplicationDocumentsDirectory();
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    // String filePathBook = '$appDirPath/fileBookJson.json';
    String filePathBook = '$appDirPath/fileBookJson.json';
    String jsonStringBook = await File(filePathBook).readAsString();

    List<dynamic> jsonDataBook = json.decode(jsonStringBook);
    return jsonDataBook.map((data) {
      final x = data["date"].toString().split('-');
      int day = int.parse(x[2].split(" ")[0]);
      return BookClass(
        id: data["id"],
        title: data["title"],
        author: data["author"],
        version: data["version"],
        note: data["note"],
        resume: data["resume"],
        category: data["category"],
        couverture: data["couverture"],
        nbrPage: data["nbrPage"],
        //date: data["date"],
        date: DateTime(int.parse(x[0]), int.parse(x[1]), day),
        status: 'finished',
      );
    }).toList();
  }

//DateTime(data["date"])
  static majWishlist() async {
    // Directory appDir = await getApplicationDocumentsDirectory();
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    String filePathWishlist = '$appDirPath/fileWishlistJson.json';
    String jsonStringWishlist = await File(filePathWishlist).readAsString();

    List<dynamic> jsonDataWishlist = json.decode(jsonStringWishlist);
    return jsonDataWishlist.map((data) {
      return WishlistClass(
        id: data["id"],
        title: data["title"],
        author: data["author"],
        version: data["version"],
        resume: data["resume"],
        category: data["category"],
        nbrPage: data["nbrPage"],
      );
    }).toList();
  }
}
