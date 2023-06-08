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
  List<BookClass> finishedLists = BookModel.getAllData()
      .where((element) => element.isFinished == true)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pile à lire')),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) newIndex--;
          books.addAll(finishedLists);
          await BookModel.updateBookList(books, oldIndex, newIndex);
          setState(() {
            books = BookModel.getAllData()
                .where((element) => element.isFinished == false)
                .toList();
          });
        },
        children: [
          for (int i = 0; i < books.length; i++)
            Container(
                color: const Color.fromARGB(255, 71, 60, 59),
                margin: const EdgeInsets.all(2),
                key: ValueKey(books[i]),
                child: ListTile(
                  leading: Icon(Icons.rectangle_rounded,
                      color: (books[i].note == "5")
                          ? const Color.fromARGB(255, 216, 3, 253)
                          : (books[i].note == "4")
                              ? const Color.fromARGB(255, 233, 121, 253)
                              : const Color.fromARGB(255, 172, 119, 182)),
                  title: Text(books[i].title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    books[i].author,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ShowBook(
                              idBook: books[i].id,
                              isFinished: false,
                            )),
                      ),
                    );
                  },
                )),
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
