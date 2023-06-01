import 'package:andrianiaiina_quote/widgets/cardBook.dart';
import 'package:flutter/material.dart';
import 'widgets/book_formulaire.dart';
import 'widgets/style.dart';
import 'book/show_book.dart';
import 'models/BookModel.dart';

class PilALire extends StatefulWidget {
  const PilALire({Key? key}) : super(key: key);

  @override
  State<PilALire> createState() => _PilALireState();
}

class _PilALireState extends State<PilALire> {
  List<BookClass> books = BookModel.getAllData()
      .where((element) => element.isFinished == false)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pile à lire')),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) newIndex--;
          await BookModel.updateBookList(books, oldIndex, newIndex);
          setState(() {
            books = BookModel.getAllData()
                .where((element) => element.isFinished == false)
                .toList();
          });
        },
        children: [
          for (int i = 0; i < books.length; i++)
            ListTile(
              key: ValueKey(books[i]),
              // key: ValueKey(books[i].id),
              title: Text(books[i].title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(books[i].author),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ShowBook(idBook: books[i].id)),
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'h1',
        backgroundColor: Colors.black,
        onPressed: () {
          showForm(
            context,
            const BookFormulaire(
              isFinished: false,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
/**
 * BookModel.updateBookList(books[oldIndex], books[newIndex]);
          setState(() {
            books = BookModel.getAllData()
                .where((element) => element.isFinished == false)
                .toList();
          });
 */