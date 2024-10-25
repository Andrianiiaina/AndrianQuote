import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:andrianiaiina_quote/book/book_formulaire.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../widgets/widget.dart';

class ShowBook extends StatefulWidget {
  final int idBook;
  const ShowBook({Key? key, required this.idBook}) : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  late BookClass? book;
  late int note;

  @override
  void initState() {
    super.initState();
    book = BookModel.getBook(widget.idBook);
    note = book!.note;
  }

  _deleteBook(int id) async {
    await BookModel.deleteBook(id);
    await StatisticModel.populateStatistic();
    showMessage(context, "Le livre a bien été supprimé.");
    context.go('/books');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              showConfirmation(context, "Confirmation",
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
                    height: 160,
                    width: 90,
                    child: (book!.couverture.isEmpty)
                        ? const Image(
                            image: AssetImage('assets/p (10).jpg'),
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(book!.couverture),
                          ),
                  ),
                  SizedBox(
                    height: 160,
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Color.fromARGB(255, 180, 58, 201),
              ),
              child: ListTile(
                textColor: Colors.grey,
                title: const Text(
                  'A propos:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                subtitle: Text(
                    book!.status != "finished"
                        ? "Livre non términé\n ${book!.nbrPage.toString()}pages.\nVersion ${book!.version.toLowerCase()}\nCategorie: ${book!.category}\n"
                        : "${book!.resume}\n\n${book!.nbrPage.toString()} pages.\nVersion ${book!.version.toLowerCase()}\nLu le ${book!.date.year}-${book!.date.month}-${book!.date.day}\nCategorie: ${book!.category}\n",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 206, 198, 198))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
