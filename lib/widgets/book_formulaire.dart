import '../author/author.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:hive/hive.dart';
import 'style.dart';

class BookFormulaire extends StatefulWidget {
  const BookFormulaire({Key? key}) : super(key: key);
  @override
  State<BookFormulaire> createState() => _BookFormulaireState();
}

class _BookFormulaireState extends State<BookFormulaire> {
  final box = Hive.box<BookClass>('book');
  @override
  Widget build(BuildContext context) {
    TextEditingController _author = TextEditingController();
    TextEditingController _title = TextEditingController();
    TextEditingController _category = TextEditingController();
    TextEditingController _note = TextEditingController();

    return Column(
      children: [
        TextWidget("Ajouter un livre"),
        TextField(
          controller: _author,
          decoration: const InputDecoration(hintText: "Nom de l'auteur"),
        ),
        TextField(
          controller: _title,
          decoration: const InputDecoration(hintText: "titre"),
        ),
        TextField(
          controller: _category,
          decoration: const InputDecoration(hintText: "category"),
        ),
        TextField(
          controller: _note,
          decoration: const InputDecoration(hintText: "note"),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
            onPressed: () async {
              final BookClass newBook = BookClass(
                  author: _author.text,
                  title: _title.text,
                  category: _category.text,
                  note: _note.text,
                  isFinished: true,
                  version: 'fr');
              _addBook(newBook);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const AuthorPage()),
                ),
              );
              //message bien enregistrer
            },
            child: const Text('Enregistrer'))
      ],
    );
  }

  _addBook(BookClass values) async {
    await box.add(values);
  }
}
