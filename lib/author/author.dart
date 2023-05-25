import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/models.dart';
import '../widgets/cardAuthor.dart';
import '../widgets/cardBook.dart';
import '../widgets/book_formulaire.dart';
import '../widgets/author_formulaire.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  State<AuthorPage> createState() => AuthorPage_State();
}

class AuthorPage_State extends State<AuthorPage> {
  late List<AuthorClass> authors = [];
  late List<BookClass> books = [];
  final box = Hive.box<AuthorClass>('author');
  final bookBox = Hive.box<BookClass>('book');

  @override
  void initState() {
    super.initState();

    final data = box.keys.map((e) {
      final aut = box.get(e);
      return AuthorClass(
          id: e,
          author: aut!.author,
          biography: aut.biography,
          books: aut.books,
          profile: aut.profile);
    }).toList();

    final databook = bookBox.keys.map((e) {
      final book = bookBox.get(e);
      return BookClass(
          id: e,
          author: book!.author,
          title: book.title,
          version: book.version,
          category: book.category,
          note: book.note,
          isFinished: book.isFinished);
    }).toList();

    authors = data.reversed.toList();
    books = databook.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.search), hintText: "rechercher un auteur"),
            onSubmitted: (q) {},
          ),
          ListTile(
            title: const Text("Sh"),
            onTap: () {},
            trailing: IconButton(
                onPressed: () {
                  _showForm(context, const FormulaireAuthor());
                },
                icon: const Icon(Icons.add)),
          ),
          SizedBox(height: 100, child: cardAuthor(authors)),
          ListTile(
            title: const Text("Books"),
            //Pour voir tous les livres
            onTap: () {},
            trailing: IconButton(
                //Pour creer un new book
                onPressed: () {
                  _showForm(
                      context,
                      const BookFormulaire(
                        isFinished: true,
                      ));
                },
                icon: const Icon(Icons.add)),
          ),
          cardBook(books),
        ],
      ),
    );
  }

  _showForm(BuildContext context, link) async {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: ((_) => Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 100), child: link)));
  }
}
