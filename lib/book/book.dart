import 'dart:math';

import 'package:andrianiaiina_quote/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'book_formulaire.dart';
import '../widgets/widget.dart';
import '../models/book_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  final List<BookClass> books = BookModel.getAllData().toList();
  @override
  void initState() {
    super.initState();
    books.removeWhere((element) => element.id == 0);
    books.sort(((a, b) => b.date.compareTo(a.date)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text('Mes livres :(${books.length})'),
        actions: [
          IconButton(
            onPressed: () {
              showForm(context, const BookFormulaire());
            },
            icon: const Icon(Icons.add_rounded),
          ),
          IconButton(
              onPressed: () {
                showForm(context, const SearchBook());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          decoration: BoxDecoration(
              border: Border(
                  left: const BorderSide(width: 15, color: Colors.brown),
                  right: const BorderSide(width: 15, color: Colors.brown),
                  bottom: const BorderSide(width: 15, color: Colors.brown),
                  top: BorderSide(
                      width: 30,
                      color: Theme.of(context).colorScheme.background))),
          child: MasonryGridView.count(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: books.length,
              crossAxisCount: 10,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              itemBuilder: (context, index) {
                BookClass book = books[index];
                return GestureDetector(
                  onTap: () {
                    context.go('/book/${book.id}');
                  },
                  child: Container(
                    height: 170,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              const BorderSide(width: 10, color: Colors.brown),
                          top: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.background)),
                    ),
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: bookColors[book.note],
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(3),
                                  topRight: Radius.circular(3))),
                          height: 100,
                          width: 130 + Random().nextInt(5) * 5.5,
                          child: Text(
                            index < books.length
                                ? "${book.title} - ${book.author}"
                                : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        )),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
