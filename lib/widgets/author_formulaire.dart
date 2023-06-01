import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/style.dart';
import '../main.dart';
import '../models/authorModel.dart';
import 'style.dart';

class FormulaireAuthor extends StatefulWidget {
  const FormulaireAuthor({Key? key}) : super(key: key);
  @override
  State<FormulaireAuthor> createState() => _FormulaireAuthorState();
}

class _FormulaireAuthorState extends State<FormulaireAuthor> {
  List<String> listBooky = [];
  final TextEditingController _author = TextEditingController();
  final TextEditingController _biographie = TextEditingController();
  final TextEditingController _books = TextEditingController();

  String _imageFile = "";

  late List<String> listBooks;
  @override
  void initState() {
    super.initState();
    listBooks = [];
  }

  final ImagePicker _picker = ImagePicker();
  _pickPhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base = base64UrlEncode(bytes);
      setState(() {
        _imageFile = base;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textWidget('Ajouter un auteur'),
        const SizedBox(height: 25),
        textFieldWidget(_author, "Nom de l'auteur", false),
        Text(listBooks.toString()),
        Row(
          children: [
            Expanded(child: textFieldWidget(_books, "un autre livre", false)),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_books.text != " " && _books.text != "")
                        listBooks.add(_books.text);
                    });
                    _books.clear();
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
        ),
        textareaWidget(_biographie, "Biographie", false),
        FloatingActionButton(
          onPressed: () {
            _pickPhoto(ImageSource.gallery);
          },
          heroTag: 'image0',
          tooltip: 'profil_author',
          child: const Icon(Icons.photo),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
            onPressed: () async {
              if (_books.text != " " && _books.text != "") {
                listBooks.add(_books.text);
              }
              _addAuthor(AuthorClass(
                  author: _author.text,
                  biography: _biographie.text,
                  books: listBooks,
                  profile: _imageFile));
              //message bien enregistrer
            },
            child: const Text('Enregistrer'))
      ],
    );
  }

  _addAuthor(AuthorClass values) async {
    await AuthorModel.addAuthor(values);
    listBooky = [];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }
}
