import 'package:andrianiaiina_quote/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'wishlist/wishlist.dart';
import 'quote/quote.dart';
import 'book/book.dart';
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

  //await Hive.deleteBoxFromDisk("quoty");
  //await Hive.deleteBoxFromDisk("book");
  await Hive.openBox<QuotyClass>("quoty");
  await Hive.openBox<BookClass>("book");
  await Hive.openBox<WishlistClass>("wishlist");

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
          _loadSavedTheme(context, value);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fenitra book',
            theme: theme_light,
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
                items: _bottomDatas,
                //backgroundColor: Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}

final theme_light = ThemeData.light().copyWith(
  backgroundColor: Colors.deepPurple,
  listTileTheme: ListTileThemeData(textColor: Colors.black54),
  hintColor: Colors.grey,
  primaryColorLight: Colors.white,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.deepPurple,
      onPrimary: Colors.white,
      secondary: Colors.purple,
      onSecondary: Colors.purple,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.purple,
      onBackground: Colors.purple,
      surface: Colors.purple,
      onSurface: Colors.white), //ex: style underline
);

_loadSavedTheme(BuildContext context, ThemeProvider themeProvider) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? true;
  themeProvider.toggleTheme(isDarkMode);
}

final _bottomDatas = [
  const BottomNavigationBarItem(
      icon: const Icon(Icons.book), label: 'Books', tooltip: "Books"),
  const BottomNavigationBarItem(
      icon: const Icon(Icons.bookmark), label: 'quote', tooltip: "Quotes"),
  const BottomNavigationBarItem(
      icon: const Icon(Icons.watch_later),
      label: 'wishlist',
      tooltip: "wishlist"),
];
