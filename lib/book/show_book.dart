import 'package:andrianiaiina_quote/widgets/book_formulaire.dart';
import 'dart:io';
import '/main.dart';
import 'package:flutter/material.dart';
import '../models/BookModel.dart';
import '../widgets/style.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp(index: 0)),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(" Details"),
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
              _deleteBook(widget.idBook);
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
                                Expanded(child: Text('(${note}/10)'))
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A propos:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(book!.resume,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 206, 198, 198))),
                  const SizedBox(height: 20),
                  Text(
                    "Categorie: ${book!.category}\n${book!.nbrPage.toString()} pages\nVersion ${book!.version.toLowerCase()}\nLu le ${book!.date.year}-${book!.date.month}-${book!.date.day}",
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
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

  _deleteBook(int id) async {
    await BookModel.deleteBook(id);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }
}
