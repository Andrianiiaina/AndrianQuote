import '/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/BookModel.dart';
import '../models/authorClass.dart';

//todo:redirection after modification
class ShowBook extends StatefulWidget {
  final int idBook;
  const ShowBook({Key? key, required this.idBook}) : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  final authorbox = Hive.box<AuthorClass>("author");

  late BookClass? book;
  late bool isAuthorExist;
  @override
  void initState() {
    super.initState();
    book = BookModel.getBook(widget.idBook);
    isAuthorExist = authorbox.values
        .where((element) => element.author == book?.author)
        .isNotEmpty;
  }

  _deleteBook(int id) async {
    await BookModel.deleteBook(id);
    final idPage = (book?.isFinished == true) ? 0 : 2;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MyApp(index: idPage)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${book?.title}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteBook(widget.idBook);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          TextButton(
              onPressed: () {
                if (isAuthorExist) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ShowBook(
                          idBook: authorbox.values
                              .firstWhere(
                                  (element) => element.author == book!.author)
                              .id)),
                    ),
                  );
                }
              },
              child: Text("Auteur: ${book?.author}")),
          Text("Categorie: ${book?.category}"),
          const SizedBox(height: 30),
          Text("Version: ${book?.version}"),
        ],
      ),
    );
  }
}
