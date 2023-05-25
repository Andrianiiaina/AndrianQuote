import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';
import 'author/author.dart';
import 'pil.dart';
import 'quote/quote.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteClassAdapter());
  Hive.registerAdapter(AuthorClassAdapter());
  Hive.registerAdapter(BookClassAdapter());

  //await Hive.deleteBoxFromDisk("quoty");
  // await Hive.deleteBoxFromDisk("author");
  // await Hive.deleteBoxFromDisk("book");

  await Hive.openBox<QuoteClass>("quoty");
  await Hive.openBox<AuthorClass>("author");
  await Hive.openBox<BookClass>("book");

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

class _MyAppState extends State<MyApp> {
  late int currentPage;
  final screen = [
    const AuthorPage(),
    const QuotePage(),
    const PilALire(),
  ];
  @override
  void initState() {
    super.initState();
    currentPage = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fenitra book',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: screen,
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: Color.fromARGB(197, 255, 255, 255)),
                label: 'authors',
                tooltip: "Authors"),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.book, color: Color.fromARGB(197, 255, 255, 255)),
                label: 'quote',
                tooltip: "Quotes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded,
                    color: Color.fromARGB(197, 255, 255, 255)),
                label: 'pile à lire',
                tooltip: "pil")
          ],
        ),
      ),
    );
  }
}
