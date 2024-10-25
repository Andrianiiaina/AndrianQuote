import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'wishlist_formulaire.dart';
import '../widgets/widget.dart';
import '../models/wishlist_model.dart';

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
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text('Wishlists'),
        actions: [
          IconButton(
              onPressed: () {
                showForm(
                  context,
                  const WishlistFormulaire(),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.1),
                      margin: const EdgeInsets.all(2),
                      key: ValueKey(wishlistsFiltered[i].id),
                      child: ListTile(
                        title: Text(wishlistsFiltered[i].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          wishlistsFiltered[i].author,
                        ),
                        onTap: () {
                          context.go('/wishlist/${wishlistsFiltered[i].id}');
                        },
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
