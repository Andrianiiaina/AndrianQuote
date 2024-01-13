import 'package:andrianiaiina_quote/models/statisticModel.dart';
import 'package:flutter/material.dart';

import '../models/WishlistModel.dart';
import '../models/BookModel.dart';
import '../models/sauvegarde.dart';
import '../models/QuoteModel.dart';
import '../main.dart';
import 'package:provider/provider.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Darkmode', style: TextStyle(color: Colors.white)),
          trailing: Consumer<ThemeProvider>(
            builder: ((context, themeProvider, _) {
              return Switch(
                  value: themeProvider.currentThemeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  });
            }),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              statisticModel.populateStatistic();
            },
            child: const Text(
              'populate',
              style: TextStyle(color: Colors.white),
            )),
        ElevatedButton(
            onPressed: () {
              sauvegarde.exportToJson();
            },
            child: const Text(
              'Sauvegarder sur internet',
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              BookModel.recupJsonDataBook();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp(index: 0)),
                ),
              );
            },
            child: const Text('Récupérer les dérnières données de book',
                style: TextStyle(color: Colors.white))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              QuoteModel.recupJsonDataQuote();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp(index: 1)),
                ),
              );
            },
            child: const Text('Récupérer les dérnières données de quote',
                style: TextStyle(color: Colors.white))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp(index: 2)),
                ),
              );
              WishlistModel.recupJsonDataWishlist();
            },
            child: const Text('Récupérer les dérnières données de wishlist',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}
