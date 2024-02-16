import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/wishlist_model.dart';
import '../models/book_model.dart';
import '../models/sauvegarde.dart';
import '../models/quote_model.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
            title: const Text('Darkmode'),
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
                try {
                  statisticModel.populateStatistic();
                } catch (e) {
                  showMessage(context,
                      "Une erreur s'est produite, veuillez réessayer.");
                }
                context.go('/');
              },
              child: const Text('Mettre à jour les statistiques')),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                try {
                  BookModel.recupJsonDataBook();
                  QuoteModel.recupJsonDataQuote();
                  WishlistModel.recupJsonDataWishlist();
                } catch (e) {
                  showMessage(context,
                      "Une erreur s'est produite.\n Si vous avez bien exporté vos données antérierement, contactez nous.\n Si vous aviez changer d'appareil, connecter vous à votre compte et dans parametre, appuyer sur restauration données.");
                }
                context.go('/');
                Navigator.pop(context);
              },
              child: const Text('Récupérer les données sauvegardées.')),
          TextButton(
              onPressed: () {
                sauvegarde.exportToJson();
                context.go('/');
                Navigator.pop(context);
              },
              child: const Text('Sauvegarder sur internet.')),
          TextButton(
              onPressed: () {
                sauvegarde.dataRestauration();
                Navigator.pop(context);
              },
              child: const Text('Restaurer les données.')),
          TextButton(
              onPressed: () {
                _auth.currentUser != null
                    ? _auth.signOut()
                    : context.go('/login');

                Navigator.pop(context);
              },
              child: Text(
                  _auth.currentUser != null ? 'Deconnection' : 'Inscription')),
        ],
      ),
    );
  }
}
