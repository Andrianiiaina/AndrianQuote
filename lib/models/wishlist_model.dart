import 'package:andrianiaiina_quote/models/sauvegarde.dart';
import 'package:hive/hive.dart';
import 'wishlist_class.dart';
export 'wishlist_class.dart';

final box = Hive.box<WishlistClass>('wishlist');

class WishlistModel {
  static getAllData() {
    return box.keys.map((e) {
      final book = box.get(e);
      return WishlistClass(
          id: e,
          author: book!.author,
          title: book.title,
          version: book.version,
          category: book.category,
          resume: book.resume,
          nbrPage: book.nbrPage);
    }).toList();
  }

  static Future deleteWishlist(int id) async {
    await box.delete(id);
  }

//utiliser sur pile à lire pour le reordablelist
  static updateWishlistList(wishlists) async {
    box.clear();
    box.addAll(wishlists);
  }

  static getWishlist(int id) {
    return box.get(id);
  }

  static addWishlist(WishlistClass values) async {
    await box.add(values);
  }

  static updateWishlist(idwishlist, WishlistClass values) async {
    await box.put(idwishlist, values);
  }

  static recupJsonDataWishlist() async {
    final List<WishlistClass> wishlists = await sauvegarde.majWishlist();
    box.clear();
    box.addAll(wishlists);
  }
}
