import 'package:andrianiaiina_quote/models/biblioClass.dart';
import 'package:andrianiaiina_quote/statistic.dart';
import 'package:andrianiaiina_quote/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'wishlist/wishlist.dart';
import 'quote/quote.dart';
import 'book/book.dart';
import 'widgets/style.dart';
import '../models/WishlistModel.dart';
import '../models/BookModel.dart';
import '../models/QuoteModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuotyClassAdapter());
  Hive.registerAdapter(BookClassAdapter());
  Hive.registerAdapter(WishlistClassAdapter());
  Hive.registerAdapter(BiblioClassAdapter());

  //await Hive.deleteBoxFromDisk("biblio");
  //await Hive.deleteBoxFromDisk("book");
  //await Hive.deleteBoxFromDisk("wishlist");
  //await Hive.deleteBoxFromDisk("quoty");

  await Hive.openBox<QuotyClass>("quoty");
  await Hive.openBox<BookClass>("book");
  await Hive.openBox<WishlistClass>("wishlist");
  await Hive.openBox<BiblioClass>("biblio");

  final book = Hive.box<BookClass>('book');

  if (!book.containsKey(0)) {
    book.put(
        0,
        BookClass(
          title: "Autre",
          author: "",
          version: "",
          note: "",
          resume: "A utiliser quand quote.book n'est pas dans book",
          category: "all",
          couverture: "",
          nbrPage: "",
          date: DateTime.now(),
          debut: DateTime.now(),
          status: "finished",
          isPaper: true,
        ));
  }
  runApp(const MyApp(
    index: 1,
  ));
}

class MyApp extends StatefulWidget {
  final int index;

  const MyApp({Key? key, required this.index}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get currentThemeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}

class _MyAppState extends State<MyApp> {
  late int currentPage;
  final screen = [
    const BookPage(),
    const QuotePage(),
    const StatisticPage(),
    const Wishlist(),
  ];
  @override
  void initState() {
    super.initState();
    currentPage = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: ((context, value, _) {
          //_loadSavedTheme(value);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fenitra book',
            theme: themeLight,
            darkTheme: ThemeData.dark(),
            themeMode: value.currentThemeMode,
            home: Scaffold(
              drawer: const Drawer(
                backgroundColor: Colors.transparent,
                child: Settings(),
              ),
              body: IndexedStack(
                index: currentPage,
                children: screen,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentPage,

                onTap: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                items: bottomDatas,
                //backgroundColor: Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}

_loadSavedTheme(ThemeProvider themeProvider) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? true;
  themeProvider.toggleTheme(isDarkMode);
}
