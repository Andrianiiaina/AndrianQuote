import 'package:andrianiaiina_quote/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/widget.dart';
import 'models/wishlist_class.dart';
import 'models/book_class.dart';
import 'models/quoty_class.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/statistic_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(QuotyClassAdapter());
  Hive.registerAdapter(BookClassAdapter());
  Hive.registerAdapter(WishlistClassAdapter());
  Hive.registerAdapter(StatisticClassAdapter());

  //await Hive.deleteBoxFromDisk("stats");
  //await Hive.deleteBoxFromDisk("book");
  //await Hive.deleteBoxFromDisk("wishlist");
  //await Hive.deleteBoxFromDisk("quoty");

  await Hive.openBox<QuotyClass>("quoty");
  await Hive.openBox<BookClass>("book");
  await Hive.openBox<WishlistClass>("wishlist");
  await Hive.openBox<StatisticClass>("stats");

  runApp(const MyApp(index: 1));
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: ((context, value, _) {
          _loadSavedTheme(value);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Andrian book',
            theme: themeLight,
            darkTheme: ThemeData.dark(),
            themeMode: value.currentThemeMode,
            routerConfig: Models.router,
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
