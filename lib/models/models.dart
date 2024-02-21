import 'package:andrianiaiina_quote/widgets/search_result.dart';
import 'package:andrianiaiina_quote/wishlist/show_wishlist.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:andrianiaiina_quote/authentification/login.dart';
import 'package:andrianiaiina_quote/authentification/register.dart';
import 'package:andrianiaiina_quote/book/show_book.dart';
import 'package:andrianiaiina_quote/main_page.dart';
//import 'package:andrianiaiina_quote/quote/show_quotedart';
import 'package:andrianiaiina_quote/quote/quote.dart';

class Models {
  static final List<Map<String, dynamic>> bookCategory = [
    {'value': 'tout', 'label': 'Touts'},
    {'value': 'BD/mangas/Fiction', 'label': 'BD/mangas/fiction'},
    {
      'value': 'Biographie/Autobiographie',
      'label': 'Biographie/Autobiographie'
    },
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Développement personnel', 'label': 'Développement personnel'},
    {'value': 'Essai/document', 'label': 'Essai/document'},
    {
      'value': 'Histoire/linguistique/etc',
      'label': 'Histoire/linguistique/etc'
    },
    {'value': 'Jeunesse', 'label': 'Jeunesse'},
    {'value': 'Policier', 'label': 'Policier'},
    {'value': 'Roman', 'label': 'Roman'},
    {'value': 'Romance', 'label': 'Romance'},
    {'value': 'SF/Fantasy', 'label': 'SF/Fantasy'},
    {'value': 'Théatre/Poesie', 'label': 'Théatre/Poesie'},
    {'value': 'Thriller/Horreur', 'label': 'Thriller/Horreur'},
    {'value': 'Nouvelle', 'label': 'Nouvelle'},
    {'value': 'Philosophie', 'label': 'Philosophie'},
    {'value': 'autre', 'label': 'Autre'},
  ];

  static final List<Map<String, dynamic>> bookversion = [
    {'value': 'Francaise', 'label': 'Francaise'},
    {'value': 'Anglaise', '': 'Anglaise'},
    {'value': 'Malgache', 'label': 'Malgache'},
    {'value': 'tout', 'label': 'Toutes'}
  ];
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MainPage(index: 1);
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const Register();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const Login();
            },
          ),
          GoRoute(
            path: 'books',
            builder: (BuildContext context, GoRouterState state) {
              return const MainPage(index: 0);
            },
          ),
          GoRoute(
            path: 'quotes',
            builder: (BuildContext context, GoRouterState state) {
              return const MainPage(index: 1);
            },
          ),
          GoRoute(
            path: 'book/:idBook',
            builder: (BuildContext context, GoRouterState state) {
              return ShowBook(
                  idBook: int.parse(
                state.pathParameters['idBook'].toString(),
              ));
            },
          ),
          GoRoute(
            path: 'quote/:id',
            builder: (BuildContext context, GoRouterState state) {
              return ShowQuote(
                  idQuote: int.parse(
                state.pathParameters['id'].toString(),
              ));
            },
          ),
          GoRoute(
            path: 'statistics',
            builder: (BuildContext context, GoRouterState state) {
              return const MainPage(index: 2);
            },
          ),
          GoRoute(
            path: 'wishlists',
            builder: (BuildContext context, GoRouterState state) {
              return const MainPage(index: 3);
            },
          ),
          GoRoute(
            path: 'wishlist/:id',
            builder: (BuildContext context, GoRouterState state) {
              return ShowWishlist(
                  idWishlist: int.parse(state.pathParameters['id'].toString()));
            },
          ),
          GoRoute(
            path: 'search_book/:type/:year',
            builder: (BuildContext context, GoRouterState state) {
              return SearchBook(
                type: int.parse(state.pathParameters['type'].toString()),
                year: int.parse(state.pathParameters['year'].toString()),
              );
            },
          ),
        ],
      ),
    ],
  );
}

class StatFinishedPerMonth {
  DateTime month;
  int bookTotal;
  StatFinishedPerMonth(this.month, this.bookTotal);
}

class StatCategories {
  String category;
  int number;
  StatCategories(this.category, this.number);
}
