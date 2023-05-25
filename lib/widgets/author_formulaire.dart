import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../models/models.dart';
import '../widgets/style.dart';
import 'dart:async';

class FormulaireAuthor extends StatefulWidget {
  const FormulaireAuthor({Key? key}) : super(key: key);
  @override
  State<FormulaireAuthor> createState() => _FormulaireAuthorState();
}

class _FormulaireAuthorState extends State<FormulaireAuthor> {
  List<String> listBooky = [];
  final box = Hive.box<AuthorClass>('author');
  // PickedFile? _imageFile;
  @override
  void initState() {
    super.initState();
    listBooky = [];
  }

  @override
  Widget build(BuildContext context) {
    //final ImagePicker _picker = ImagePicker();
    TextEditingController _author = TextEditingController();
    TextEditingController _biographie = TextEditingController();
    TextEditingController _image = TextEditingController();
    TextEditingController _books = TextEditingController();
    Future<void> _pickPhoto(ImageSource source) async {
      // final pickedFile = await _picker.getImage(source: source);

      // setState(() {
      // _imageFile = pickedFile;
      //});
    }

    return Column(
      children: [
        textWidget('Ajouter un auteur'),
        const SizedBox(height: 25),
        textFieldWidget(_author, "Nom de l'auteur"),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _books,
                decoration: const InputDecoration(hintText: "Livres"),
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    listBooky.add(_books.text);
                    _books.clear();
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
        ),
        TextField(
          controller: _biographie,
          decoration: const InputDecoration(hintText: "Biographie"),
          keyboardType: TextInputType.multiline,
          maxLines: 9,
          minLines: 4,
        ),
        TextField(
          controller: _image,
        ),
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
              listBooky.add(_books.text);
              listBooky.remove(' ');
              final AuthorClass newAuthor = AuthorClass(
                  author: _author.text,
                  biography: _biographie.text,
                  books: listBooky,
                  profile: _image.text);
              _addAuthor(newAuthor);
              //message bien enregistrer
            },
            child: const Text('Enregistrer'))
      ],
    );
  }

  _addAuthor(AuthorClass values) async {
    await box.add(values);
    listBooky = [];
  }
}
