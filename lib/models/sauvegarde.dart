import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'quoty_class.dart';
import 'dart:convert';
import 'dart:io';
import 'book_class.dart';
import 'wishlist_class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final boxQuote = Hive.box<QuotyClass>('quoty');
final boxBook = Hive.box<BookClass>('book');
final boxWishlist = Hive.box<WishlistClass>('wishlist');
final FirebaseAuth _auth = FirebaseAuth.instance;

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
        'debut': value.date.toString(),
        'isPaper': value.isPaper,
        //'debut': value.debut,
        //'isPaper': value.isPaper,
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
    File fileBook = File('$appDirPath/fileBookJson.json');
    File fileWishlist = File('$appDirPath/fileWishlistJson.json');
    File fileQuote = File('$appDirPath/fileQuoteJson.json');
    try {
      await fileBook.writeAsString(json.encode(dataBook));
      await fileQuote.writeAsString(json.encode(dataQuote));
      await fileWishlist.writeAsString(json.encode(dataWishlist));
    } finally {}
    //si user connécté=> data sauvegardé sur firebase
    if (_auth.currentUser != null) {
      try {
        final childRef = _auth.currentUser!.uid;
        final storageRef = FirebaseStorage.instance.ref();
        final spaceRef1 = storageRef.child("$childRef/fileBookJson.json");
        final spaceRef2 = storageRef.child("$childRef/fileQuoteJson.json");
        final spaceRef3 = storageRef.child("$childRef/fileWishlistJson.json");
        await spaceRef1.putFile(fileBook);
        await spaceRef2.putFile(fileQuote);
        await spaceRef3.putFile(fileWishlist);
      } finally {}
    }
  }

  static dataRestauration() async {
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    if (_auth.currentUser != null) {
      try {
        final childRef = _auth.currentUser!.uid;
        final storageRef = FirebaseStorage.instance.ref("");
        final spaceRef1 = storageRef.child("$childRef/fileBookJson.json");
        final spaceRef2 = storageRef.child("$childRef/fileQuoteJson.json");
        final spaceRef3 = storageRef.child("$childRef/fileWishlistJson.json");

        File fileBook = File('$appDirPath/fileBookJson.json');
        File fileWishlist = File('$appDirPath/fileWishlistJson.json');
        File fileQuote = File('$appDirPath/fileQuoteJson.json');

        spaceRef1.writeToFile(fileBook);
        spaceRef2.writeToFile(fileQuote);
        spaceRef3.writeToFile(fileWishlist);
      } finally {}
    }
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
      //fond: 'assets/p (${Random().nextInt(35) + 1}).jpg');
    }).toList();
  }

  static majBook() async {
    //Directory appDir = await getApplicationDocumentsDirectory();
    final appDir = await getExternalStorageDirectory();
    String appDirPath = appDir!.path;
    // String filePathBook = '$appDirPath/fileBookJson.json';
    String filePathBook = '$appDirPath/fileBookJson.json';
    String jsonStringBook = await File(filePathBook).readAsString();

    List<dynamic> jsonDataBook = json.decode(jsonStringBook);
    return jsonDataBook.map((data) {
      final x = data["date"].toString().split('-');
      final y = data["debut"].toString().split('-');
      int day = int.parse(x[2].split(" ")[0]);
      return BookClass(
        id: data["id"],
        title: data["title"],
        author: data["author"],
        version: data["version"],
        note: int.tryParse(data["note"].toString()) ?? 0,
        resume: data["resume"],
        category: data["category"],
        couverture: data["couverture"],
        nbrPage: int.tryParse(data["nbrPage"].toString()) ?? 0,
        date: DateTime(int.parse(x[0]), int.parse(x[1]), day),
        debut: DateTime(int.parse(y[0]), int.parse(y[1]), day),
        status: data['status'],
        isPaper: data['isPaper'],
      );
    }).toList();
  }

  static majWishlist() async {
    //Directory appDir = await getApplicationDocumentsDirectory();
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
