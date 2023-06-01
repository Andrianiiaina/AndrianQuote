import 'package:flutter/material.dart';
import '../widgets/cardAuthor.dart';
import '../widgets/cardBook.dart';
import '../widgets/book_formulaire.dart';
import '../widgets/author_formulaire.dart';
import '../widgets/style.dart';
import '../models/BookModel.dart';
import '../models/authorModel.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  State<AuthorPage> createState() => AuthorPage_State();
}

class AuthorPage_State extends State<AuthorPage> {
  final List<AuthorClass> authors = AuthorModel.getAllData();
  final List<BookClass> books = BookModel.getAllData()
      .where((element) => element.isFinished == true)
      .toList();
  List<BookClass> filterdBooks = [];
  @override
  void initState() {
    super.initState();
    filterdBooks = books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: "rechercher un auteur ou un livre"),
            onChanged: (q) {
              search(q);
            },
          ),
          listTileAddButton("Authors", const FormulaireAuthor()),
          Expanded(
              flex: 1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: authors.length,
                  itemBuilder: ((context, index) {
                    AuthorClass author = authors[index];
                    return cardAuthor(author, context);
                  }))),
          listTileAddButton("Books", const BookFormulaire(isFinished: true)),
          Expanded(
            flex: 4,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: filterdBooks.length,
                itemBuilder: ((context, index) {
                  BookClass book = filterdBooks[index];
                  return cardBook(book, context);
                })),
          )
        ],
      ),
    );
  }

  search(String q) {
    setState(() {
      filterdBooks = books
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
