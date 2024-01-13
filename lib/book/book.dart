import 'package:andrianiaiina_quote/models/models.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
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

  late bool isSearching;
  @override
  void initState() {
    super.initState();
    books.removeWhere((element) => element.id == 0);
    filteredBooks = books;
    filteredBooks.sort(((a, b) => b.date.compareTo(a.date)));
    isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text('Livres (${books.length})'),
        actions: [
          if (isSearching == true)
            SizedBox(
              width: 180,
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: "search..."),
                onChanged: (q) {
                  search(q);
                },
              ),
            ),
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                flex: 3,
                child: SelectFormField(
                  labelText: 'Category',
                  items: Models.bookCategory,
                  onChanged: (value) {
                    setState(() {
                      if (value == 'tout') {
                        filteredBooks = books;
                      } else {
                        filteredBooks = books
                            .where((element) => element.category == value)
                            .toList();
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SelectFormField(
                  labelText: 'ASC',
                  items: const [
                    {'value': 'ASC', 'label': 'ASC'},
                    {'value': 'DESC', 'label': 'DESC'}
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == 'ASC') {
                        setState(() {
                          filteredBooks
                              .sort(((a, b) => a.title.compareTo(b.title)));
                        });
                      } else {
                        setState(() {
                          filteredBooks
                              .sort(((a, b) => b.title.compareTo(a.title)));
                        });
                      }
                    });
                  },
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: filteredBooks.length,
                itemBuilder: ((context, index) {
                  BookClass book = filteredBooks[index];
                  return cardBook(book, context);
                })),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        key: const Key("add_book"),
        heroTag: 'h3',
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          showForm(context, const BookFormulaire());
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
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
}
