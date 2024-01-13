import 'package:andrianiaiina_quote/widgets/book_formulaire.dart';
import '../models/book_model.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import '../models/wishlist_model.dart';
import '../widgets/style.dart';
import '../widgets/wishlist_formulaire.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                " ${book!.title.toUpperCase()}",
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 236, 160, 249),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${book?.author}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Genre'),
                      subtitle: Text('${book?.category}'),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Langage'),
                      subtitle: Text("${book?.version}"),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Pages'),
                      subtitle: Text("${book?.nbrPage}"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  "Marquer comme lu",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 227, 122, 245),
                )),
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
                    nbrPage: int.parse(book!.nbrPage),
                    date: DateTime.now(),
                    debut: DateTime.now(),
                    isPaper: true,
                    status: 'finished',
                  );
                  BookModel.addBook(newBook);
                  //DeleteBook in wishlist
                  WishlistModel.deleteWishlist(widget.idWishlist);
                  //showBook
                  final BookClass idy = BookModel.getAllData().firstWhere((e) =>
                      (e.title == newBook.title) &&
                      (e.author == newBook.author));

                  showForm(
                      context,
                      BookFormulaire(
                        idBook: idy.id,
                      ));
                },
              ),
              const SizedBox(height: 20),
              if (book!.resume.isNotEmpty)
                ListTile(
                  title: const Text(
                    "A propos",
                    style: TextStyle(fontSize: 18, fontFamily: 'verdana'),
                  ),
                  subtitle: Text(book!.resume),
                )
            ],
          ),
        ),
      ),
    );
  }
}
