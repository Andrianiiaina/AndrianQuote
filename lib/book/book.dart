import 'package:flutter/material.dart';
import '../widgets/card_book.dart';
import '../widgets/book_formulaire.dart';
import '../widgets/style.dart';
import '../models/book_model.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  final List<BookClass> books = BookModel.getAllData().toList();
  List<BookClass> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    books.removeWhere((element) => element.id == 0);
    filteredBooks = books;
    filteredBooks.sort(((a, b) => b.date.compareTo(a.date)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text('Livres (${books.length})'),
      ),
      body: Column(
        children: [
          searchWidget(search, "filter"),
          Expanded(
            flex: 5,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: filteredBooks.length,
                itemBuilder: ((context, index) {
                  BookClass book = filteredBooks[index];
                  return cardBook(book, context);
                })),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        key: const Key("add_book"),
        heroTag: 'h3',
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          showForm(context, const BookFormulaire());
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
      ),
    );
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
