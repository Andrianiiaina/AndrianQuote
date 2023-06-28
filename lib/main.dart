import 'package:andrianiaiina_quote/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'wishlist/wishlist.dart';
import 'quote/quote.dart';
import 'book/book.dart';
import '../models/WishlistModel.dart';
import '../models/BookModel.dart';
import '../models/QuoteModel.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotee',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
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
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.book, color: Color.fromARGB(197, 255, 255, 255)),
                label: 'Books',
                tooltip: "Books"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark,
                    color: Color.fromARGB(197, 255, 255, 255)),
                label: 'quote',
                tooltip: "Quotes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.watch_later,
                    color: Color.fromARGB(197, 255, 255, 255)),
                label: 'wishlist',
                tooltip: "wishlist"),
          ],
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
