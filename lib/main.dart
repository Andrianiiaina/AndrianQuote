import 'widgets/book_formulaire.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';
import 'author/author.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteClassAdapter());
  Hive.registerAdapter(AuthorClassAdapter());
  Hive.registerAdapter(BookClassAdapter());

  //await Hive.deleteBoxFromDisk('quoty');
  //await Hive.deleteBoxFromDisk("author");
  //await Hive.deleteBoxFromDisk("book");

  await Hive.openBox<QuoteClass>("quoty");
  await Hive.openBox<AuthorClass>("author");
  await Hive.openBox<BookClass>("book");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fenitra book',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: const _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  int currentPage = 0;
  final Screen = [
    const AuthorPage(),
    const BookFormulaire(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: Screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
              icon:
                  Icon(Icons.person, color: Color.fromARGB(197, 255, 255, 255)),
              label: 'authors',
              tooltip: "Authors"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.book, color: Color.fromARGB(197, 255, 255, 255)),
              label: 'quote',
              tooltip: "Quotes"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded,
                  color: Color.fromARGB(197, 255, 255, 255)),
              label: 'pile à lire',
              tooltip: "pil")
        ],
      ),
    );
  }
}
