import 'showWishlist.dart';
import 'package:flutter/material.dart';
import '../widgets/wishlist_formulaire.dart';
import '../widgets/style.dart';
import '../models/WishlistModel.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<WishlistClass> wishlists = WishlistModel.getAllData();
  late List<WishlistClass> wishlistsFiltered;
  @override
  void initState() {
    super.initState();
    wishlistsFiltered = wishlists;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController maxC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Wishlists (${wishlists.length.toString()})')),
      body: Column(
        children: [
          Flexible(
              child: Container(
            width: 200,
            child: TextField(
              onChanged: (val) {
                setState(() {
                  (val.isNotEmpty)
                      ? wishlistsFiltered = wishlists
                          .where((element) =>
                              int.parse(element.nbrPage) <= int.parse(val))
                          .toList()
                      : wishlistsFiltered = wishlists;
                });
              },
              decoration: InputDecoration(hintText: "Nombres de page max"),
            ),
          )),
          Expanded(
            flex: 5,
            child: ReorderableListView(
              scrollDirection: Axis.vertical,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) newIndex--;

                final item = wishlistsFiltered.removeAt(oldIndex);
                wishlistsFiltered.insert(newIndex, item);

                WishlistModel.updateWishlistList(wishlistsFiltered);
                setState(() {
                  wishlistsFiltered = wishlistsFiltered;
                });
              },
              children: [
                for (int i = 0; i < wishlistsFiltered.length; i++)
                  Container(
                      color: Theme.of(context).backgroundColor.withOpacity(0.1),
                      margin: const EdgeInsets.all(2),
                      key: ValueKey(wishlistsFiltered[i].id),
                      child: ListTile(
                        leading: Icon(Icons.rectangle,
                            color: (wishlistsFiltered[i].priority == "1")
                                ? oneC
                                : (wishlistsFiltered[i].priority == "2")
                                    ? twoC
                                    : threeC),
                        title: Text(wishlistsFiltered[i].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          wishlistsFiltered[i].author,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ShowWishlist(
                                    idWishlist: wishlistsFiltered[i].id,
                                  )),
                            ),
                          );
                        },
                      )),
              ],
            ),
          ),
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
