import 'package:andrianiaiina_quote/widgets/book_formulaire.dart';

import '/main.dart';
import 'package:flutter/material.dart';
import '../models/BookModel.dart';
import 'dart:io';
import '../widgets/style.dart';

//todo:redirection after modification
class ShowBook extends StatefulWidget {
  final int idBook;
  final bool isFinished;
  const ShowBook({Key? key, required this.idBook, required this.isFinished})
      : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  late BookClass? book;
  late bool isAuthorExist;
  @override
  void initState() {
    super.initState();
    book = BookModel.getBook(widget.idBook);
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
        title: const Text(" Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showForm(
                  context,
                  BookFormulaire(
                      isFinished: widget.isFinished, idBook: widget.idBook));
            },
          ),
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
          if (book!.couverture.isNotEmpty)
            Image.file(File(book!.couverture), width: 180),
          const SizedBox(height: 30),
          if (widget.isFinished == true)
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 4,
                child: star(int.parse(book!.note)))
          else
            Icon(Icons.rectangle_rounded,
                color: (book!.note == "5")
                    ? const Color.fromARGB(255, 216, 3, 253)
                    : (book!.note == "4")
                        ? const Color.fromARGB(255, 233, 121, 253)
                        : const Color.fromARGB(255, 172, 119, 182)),
          Text("Auteur: ${book?.author}"),
          Text("Categorie: ${book?.category}"),
          const SizedBox(height: 20),
          Row(children: [
            Flexible(child: listTileWidget("Pages", book!.nbrPage.toString())),
            Flexible(child: listTileWidget("Langage", book!.version)),
            Flexible(child: listTileWidget("ISBN", book!.isbn))
          ]),
          const SizedBox(height: 20),
          ListTile(
            title: const Text(
              "A propos",
              style: TextStyle(fontSize: 18, fontFamily: 'verdana'),
            ),
            subtitle: Text(book!.resume),
          )
        ],
      ),
    );
  }

  Widget listTileWidget(titre, soutitre) {
    return ListTile(
      title: Text(
        titre,
        style: const TextStyle(fontSize: 13, fontFamily: 'verdana'),
      ),
      subtitle: Text(
        soutitre,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
