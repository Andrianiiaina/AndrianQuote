import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:andrianiaiina_quote/widgets/book_formulaire.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../widgets/style.dart';

class ShowBook extends StatefulWidget {
  final int idBook;
  const ShowBook({Key? key, required this.idBook}) : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  late BookClass? book;
  late bool isAuthorExist;
  late int note;

  @override
  void initState() {
    super.initState();
    book = BookModel.getBook(widget.idBook);
    try {
      note = int.parse(book!.note);
    } catch (e) {
      note = 0;
    }
  }

  _deleteBook(int id) async {
    await BookModel.deleteBook(id);
    await statisticModel.populateStatistic();
    showMessage(context, "Le livre a bien été supprimé.");
    context.go('/books');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book!.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showForm(context, BookFormulaire(idBook: widget.idBook));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ShowConfirmation(context, "Confirmation",
                  "Etes-vous sur de vouloir supprimer ce livre?", () {
                _deleteBook(widget.idBook);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 30 / 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    width: 80,
                    child: (book!.couverture.isEmpty)
                        ? const Image(
                            image: AssetImage('assets/p (10).jpg'),
                          )
                        : Image.file(
                            File(book!.couverture),
                          ),
                  ),
                  SizedBox(
                    height: 110,
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            "${book?.title}",
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "${book?.author}",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: star(note)),
                                Expanded(child: Text('($note/10)'))
                              ]),
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A propos:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    child: Text(
                        book!.resume == "" ? "Aucun resumé..." : book!.resume,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 206, 198, 198))),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Categorie: ${book!.category}\nPages:${book!.nbrPage.toString()}\nVersion ${book!.version.toLowerCase()}\nLu le ${book!.date.year}-${book!.date.month}-${book!.date.day}",
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
