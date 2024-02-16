import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/card_book.dart';
import '../widgets/book_formulaire.dart';
import '../widgets/style.dart';
import '../models/book_model.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  final List<BookClass> books = BookModel.getAllData().toList();
  List<BookClass> filteredBooks = [];
  List<BookClass> monthly = [];
  List<BookClass> current = [];
  @override
  void initState() {
    super.initState();
    books.removeWhere((element) => element.id == 0);
    monthly = books
        .where((element) =>
            element.date.month == DateTime.now().month &&
            element.date.year == DateTime.now().year)
        .take(8)
        .toList();
    filteredBooks = books;
    filteredBooks.sort(((a, b) => b.date.compareTo(a.date)));
    current = books
        .where((element) => element.status.contains('current'))
        .take(5)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text('Livres (${books.length})'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ce mois'),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (_, i) {
                                return Container(
                                  width: 29,
                                  decoration: BoxDecoration(
                                      color: colors[i],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                        i < monthly.length
                                            ? monthly[i].title
                                            : '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                );
                              }),
                        ),
                        Image(
                          image: AssetImage('assets/p (11).jpg'),
                          height: 100,
                          fit: BoxFit.cover,
                          width: 228,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text('Courrant'),
                          SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (_, i) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 5),
                                      padding: EdgeInsets.all(4),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: colors[Random().nextInt(7)],
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Text(
                                          i < current.length
                                              ? current[i].title
                                              : '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    );
                                  }))
                        ],
                      )),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: searchWidget(search), flex: 8),
                  Expanded(
                      child: IconButton(
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      showForm(context, const BookFormulaire());
                    },
                  ))
                ],
              ),
              Expanded(
                flex: 5,
                child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: filteredBooks.length,
                    itemBuilder: ((context, index) {
                      BookClass book = filteredBooks[index];
                      return CardBook(book: book);
                    })),
              )
            ],
          ),
        ),
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

  List<Color> colors = [
    Colors.black,
    Color.fromARGB(255, 98, 2, 145),
    Color.fromARGB(255, 65, 41, 221),
    Color.fromARGB(255, 204, 47, 186),
    Color.fromARGB(255, 88, 2, 208),
    Colors.deepPurple,
    Color.fromARGB(178, 122, 8, 142),
    Colors.black
  ];
}
