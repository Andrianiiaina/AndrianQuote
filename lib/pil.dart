import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/models.dart';
import 'widgets/book_formulaire.dart';
import 'book/show_book.dart';

class PilALire extends StatefulWidget {
  const PilALire({Key? key}) : super(key: key);
  @override
  State<PilALire> createState() => _PilALireState();
}

class _PilALireState extends State<PilALire> {
  final box = Hive.box<BookClass>('book');
  late List<BookClass> books = [];

  @override
  void initState() {
    super.initState();
    final data = box.keys.map((e) {
      final book = box.get(e);
      return BookClass(
          id: e,
          author: book!.author,
          title: book.title,
          version: book.version,
          category: book.category,
          note: book.note,
          isFinished: book.isFinished);
    }).toList();
    books =
        data.reversed.where((element) => element.isFinished == false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pile à lire')),
      body: Column(
        children: [
          Table(
            children: const [
              TableRow(children: [
                TableCell(child: Text("Titre")),
                TableCell(child: Text("Auteur")),
                TableCell(child: Text("Note")),
                TableCell(child: Text(""))
              ])
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              itemBuilder: ((context, index) {
                return Table(
                  children: [
                    TableRow(children: [
                      TableCell(child: Text(books[index].title)),
                      TableCell(child: Text(books[index].author)),
                      TableCell(child: Text(books[index].note)),
                      TableCell(
                          child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                                  ShowBook(idBook: books[index].id)),
                            ),
                          );
                        },
                        icon: (const Icon(Icons.edit)),
                      ))
                    ])
                  ],
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'h1',
        backgroundColor: Colors.black,
        onPressed: () {
          _showFormulaire(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _showFormulaire(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  left: 10,
                  top: 2,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const BookFormulaire(
                isFinished: false,
              ),
            ));
  }
}
