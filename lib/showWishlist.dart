import 'package:andrianiaiina_quote/widgets/book_formulaire.dart';

import '/models/BookModel.dart';

import '/main.dart';
import 'package:flutter/material.dart';
import '../models/WishlistModel.dart';
import '../widgets/style.dart';
import 'widgets/wishlist_formulaire.dart';

//todo:redirection after modification
class ShowWishlist extends StatefulWidget {
  final int idWishlist;
  const ShowWishlist({Key? key, required this.idWishlist}) : super(key: key);
  @override
  State<ShowWishlist> createState() => _ShowWishlistState();
}

class _ShowWishlistState extends State<ShowWishlist> {
  late WishlistClass? book;
  late bool isAuthorExist;
  @override
  void initState() {
    super.initState();
    book = WishlistModel.getWishlist(widget.idWishlist);
  }

  _deleteWishlist(int id) async {
    await WishlistModel.deleteWishlist(id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 2)),
      ),
    );
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
                  builder: ((context) => const MyApp(index: 2)),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(" Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showForm(
                  context, WishlistFormulaire(idWishlist: widget.idWishlist));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteWishlist(widget.idWishlist);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Auteur: ${book?.author}",
            style: const TextStyle(fontSize: 16),
          ),
          Text("Categorie: ${book?.category}",
              style: const TextStyle(fontSize: 16)),
          Text("Pages: ${book?.nbrPage}", style: const TextStyle(fontSize: 16)),
          Text("Langage: ${book?.version}",
              style: const TextStyle(fontSize: 16)),
          ElevatedButton(
            child: const Text(
              "Ajouter aux livres lus",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all((book!.priority == "1")
                        ? const Color.fromARGB(255, 216, 3, 253)
                        : (book!.priority == "2")
                            ? const Color.fromARGB(255, 233, 121, 253)
                            : const Color.fromARGB(255, 172, 119, 182))),
            onPressed: () {
              //addToBook
              BookClass newBook = BookClass(
                  title: book!.title,
                  author: book!.author,
                  version: book!.version,
                  note: "0",
                  resume: book!.resume,
                  category: book!.category,
                  couverture: "",
                  nbrPage: book!.nbrPage,
                  date: DateTime.now());
              BookModel.addBook(newBook);
              //DeleteBook in wishlist
              WishlistModel.deleteWishlist(widget.idWishlist);
              //showBook
              final BookClass idy = BookModel.getAllData().firstWhere((e) =>
                  (e.title == newBook.title) && (e.author == newBook.author));

              showForm(
                  context,
                  BookFormulaire(
                    idBook: idy.id,
                  ));
            },
          ),
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
}
