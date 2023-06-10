import 'package:flutter/material.dart';

import '../models/WishlistModel.dart';
import '../models/BookModel.dart';
import '../models/sauvegarde.dart';
import '../models/QuoteModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              sauvegarde.exportToJson();
            },
            child: const Text(
              'Sauvegarder in net',
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              BookModel.recupJsonDataBook();
            },
            child: const Text('recuperer data book',
                style: TextStyle(color: Colors.white))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              QuoteModel.recupJsonDataQuote();
            },
            child: const Text('recuperer data quote',
                style: TextStyle(color: Colors.white))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              WishlistModel.recupJsonDataWishlist();
            },
            child: const Text('recuperer data wishlist',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}
