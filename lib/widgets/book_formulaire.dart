import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:hive/hive.dart';
import 'style.dart';
import '../main.dart';
import 'package:select_form_field/select_form_field.dart';

class BookFormulaire extends StatefulWidget {
  final bool isFinished;
  const BookFormulaire({Key? key, required this.isFinished}) : super(key: key);
  @override
  State<BookFormulaire> createState() => _BookFormulaireState();
}

class _BookFormulaireState extends State<BookFormulaire> {
  final box = Hive.box<BookClass>('book');
  final List<Map<String, dynamic>> bookCategory = [
    {'value': 'Thriller', 'label': 'Thriller'},
    {'value': 'Romance', 'label': 'Romance'},
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Dev perso', 'label': 'Dev perso'}
  ];
  @override
  Widget build(BuildContext context) {
    TextEditingController _author = TextEditingController();
    TextEditingController _title = TextEditingController();
    TextEditingController _category = TextEditingController();
    TextEditingController _note = TextEditingController();

    return Column(
      children: [
        textWidget("Ajouter un livre"),
        TextField(
          controller: _author,
          decoration: const InputDecoration(hintText: "Nom de l'auteur"),
        ),
        TextField(
          controller: _title,
          decoration: const InputDecoration(hintText: "titre"),
        ),
        SelectFormField(
            labelText: 'Category',
            type: SelectFormFieldType.dropdown,
            controller: _category,
            items: bookCategory),
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
                  isFinished: widget.isFinished,
                  version: 'fr');
              _addBook(newBook);
              //message bien enregistrer
            },
            child: const Text('Enregistrer'))
      ],
    );
  }

  _addBook(BookClass values) async {
    await box.add(values);
    if (widget.isFinished) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const MyApp(index: 0)),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const MyApp(index: 2)),
        ),
      );
    }
  }
}
