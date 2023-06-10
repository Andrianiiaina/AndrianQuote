import 'package:andrianiaiina_quote/showWishlist.dart';
import 'package:flutter/material.dart';
import 'widgets/wishlist_formulaire.dart';
import 'widgets/style.dart';
import 'models/WishlistModel.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<WishlistClass> wishlists = WishlistModel.getAllData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) newIndex--;

          final item = wishlists.removeAt(oldIndex);
          wishlists.insert(newIndex, item);

          WishlistModel.updateWishlistList(wishlists);
          setState(() {
            wishlists = wishlists;
          });
        },
        children: [
          for (int i = 0; i < wishlists.length; i++)
            Container(
                color: const Color.fromARGB(255, 49, 44, 49),
                margin: const EdgeInsets.all(2),
                key: ValueKey(wishlists[i].id),
                child: ListTile(
                  leading: Icon(Icons.rectangle,
                      color: (wishlists[i].priority == "1")
                          ? const Color.fromARGB(255, 210, 3, 247)
                          : (wishlists[i].priority == "2")
                              ? const Color.fromARGB(255, 119, 62, 129)
                              : const Color.fromARGB(255, 202, 142, 214)),
                  title: Text(wishlists[i].title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    wishlists[i].author,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ShowWishlist(
                              idWishlist: wishlists[i].id,
                            )),
                      ),
                    );
                  },
                )),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'h1',
        backgroundColor: Colors.black,
        onPressed: () {
          showForm(
            context,
            const WishlistFormulaire(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
