import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:flutter/material.dart';
import '../widgets/card_book.dart';
import '../models/book_model.dart';

class SearchBook extends StatefulWidget {
  final int type;
  final int year;
  const SearchBook({Key? key, this.type = -1, this.year = 2024})
      : super(key: key);

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  final List<BookClass> _books = BookModel.getAllData().toList();
  List<BookClass> filteredBooks = [];
  List<BookClass> books = [];
  @override
  void initState() {
    super.initState();
    _books.removeWhere((element) => element.id == 0);

    if (widget.type == 1) {
      books = _books
          .where((element) =>
              element.status.contains('urrent') &&
              element.date.year == widget.year)
          .toList();
    } else if (widget.type == 2) {
      books = _books
          .where((element) =>
              element.status.contains('andonned') &&
              element.date.year == widget.year)
          .toList();
    } else if (widget.type == 0) {
      books = _books
          .where((element) =>
              element.status.contains('inished') &&
              element.date.year == widget.year)
          .toList();
    } else {
      books = _books;
    }
    filteredBooks = books;
    filteredBooks.sort(((a, b) => b.date.compareTo(a.date)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: false,
        ),
        body: Column(
          children: [
            searchWidget(search),
            if (filteredBooks.isEmpty)
              const Text('Aucun livre trouvé.')
            else
              Expanded(
                flex: 5,
                child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: filteredBooks.length,
                    itemBuilder: ((context, index) {
                      BookClass book = filteredBooks[index];
                      return CardBook(book: book);
                    })),
              )
          ],
        ));
  }

  search(String q) {
    setState(() {
      filteredBooks = books
          .where((element) =>
              element.title.toLowerCase().contains(q.toLowerCase()) ||
              element.author.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }
}
