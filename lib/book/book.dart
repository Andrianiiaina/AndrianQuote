import 'package:flutter/material.dart';
import '../widgets/cardBook.dart';
import '../widgets/book_formulaire.dart';
import '../widgets/style.dart';
import '../models/BookModel.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => bookPage_State();
}

class bookPage_State extends State<BookPage> {
  final List<BookClass> books = BookModel.getAllData()
      .where((element) => element.isFinished == true)
      .toList();
  List<BookClass> filteredBooks = [];

  late bool isSearching;
  @override
  void initState() {
    super.initState();
    filteredBooks = books;
    isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Andrianiiaina quote'),
        actions: [
          if (isSearching == true)
            SizedBox(
              width: 180,
              child: TextField(
                decoration: const InputDecoration(hintText: "search..."),
                onChanged: (q) {
                  search(q);
                },
              ),
            ),
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          listTileAddButton("Books", const BookFormulaire(isFinished: true)),
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

  Widget listTileAddButton(String title, Formulaire) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontFamily: "Roboto"),
      ),
      onTap: () {},
      trailing: IconButton(
          onPressed: () {
            showForm(context, Formulaire);
          },
          icon: const Icon(Icons.add)),
    );
  }
}
