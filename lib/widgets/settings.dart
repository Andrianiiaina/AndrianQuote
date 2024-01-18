import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:flutter/material.dart';

import '../models/wishlist_model.dart';
import '../models/book_model.dart';
import '../models/sauvegarde.dart';
import '../models/quote_model.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: const AssetImage('assets/p (4).jpg'),
            height: 150,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 10),
          ListTile(
            title:
                const Text('Darkmode', style: TextStyle(color: Colors.white70)),
            trailing: Consumer<ThemeProvider>(
              builder: ((context, themeProvider, _) {
                return Switch(
                    inactiveTrackColor: Colors.white,
                    activeTrackColor: Colors.white,
                    value: themeProvider.currentThemeMode == ThemeMode.dark,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    });
              }),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                statisticModel.populateStatistic();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const MyApp(index: 2)),
                  ),
                );
              },
              child: const Text(
                'Mettre à jours les statistiques',
                style: TextStyle(color: Colors.white70),
              )),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                BookModel.recupJsonDataBook();
                QuoteModel.recupJsonDataQuote();
                WishlistModel.recupJsonDataWishlist();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const MyApp(index: 1)),
                  ),
                );
              },
              child: const Text(
                'Récupérer les dérnières données sauvegardées.',
                style: TextStyle(color: Colors.white70),
              )),
          TextButton(
              onPressed: () {
                sauvegarde.exportToJson();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const MyApp(index: 1)),
                  ),
                );
              },
              child: const Text(
                'Sauvegarder sur internet',
                style: TextStyle(color: Colors.white70),
              )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
