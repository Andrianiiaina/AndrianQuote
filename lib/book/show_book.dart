import 'package:andrianiaiina_quote/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/models.dart';

//todo:redirection after modification
class ShowBook extends StatefulWidget {
  final int idBook;
  const ShowBook({Key? key, required this.idBook}) : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  final box = Hive.box<BookClass>("book");
  late BookClass? book;
  late int id;
  bool readOnly = true;
  @override
  void initState() {
    super.initState();
    id = widget.idBook;
    book = box.get(id);
  }

  _deleteBook(int id) async {
    await box.delete(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${book?.title}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteBook(id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text("Auteur: ${book?.author}"),
          Text("Categorie: ${book?.category}"),
          const SizedBox(height: 30),
          Text("Version: ${book?.version}"),
        ],
      ),
    );
  }
}
