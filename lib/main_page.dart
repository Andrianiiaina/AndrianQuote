import 'package:andrianiaiina_quote/book/book.dart';
import 'package:andrianiaiina_quote/quote/quote.dart';
import 'package:andrianiaiina_quote/statistic.dart';
import 'package:andrianiaiina_quote/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'widgets/widget.dart';

class MainPage extends StatefulWidget {
  final int index;
  const MainPage({Key? key, required this.index}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

final screen = [
  const BookPage(),
  const QuotePage(),
  const StatisticPage(),
  const Wishlist(),
];

class _MainPageState extends State<MainPage> {
  late int currentPage;
  @override
  void initState() {
    super.initState();
    currentPage = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.purple.withOpacity(0.8),
        selectedItemColor: Colors.purple,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: bottomDatas,
        backgroundColor: Colors.black,
      ),
    );
  }
}
