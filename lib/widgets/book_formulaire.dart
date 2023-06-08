import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../models/BookModel.dart';
import 'style.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BookFormulaire extends StatefulWidget {
  final bool isFinished;
  final int idBook;
  const BookFormulaire({Key? key, required this.isFinished, this.idBook = -1})
      : super(key: key);
  @override
  State<BookFormulaire> createState() => _BookFormulaireState();
}

class _BookFormulaireState extends State<BookFormulaire> {
  int stara = 0;
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController nbrpageController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  late bool version;
  String _imageFile = "";
  String currentImage = "";
  late BookClass book;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    version = true;
    if (widget.idBook != -1) {
      book = BookModel.getBook(widget.idBook);
      authorController.text = book.author;
      titleController.text = book.title;
      resumeController.text = book.resume;
      nbrpageController.text = book.nbrPage.toString();
      isbnController.text = book.isbn;
      stara = int.parse(book.note);
    }
  }

  _pickPhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/images');
      if (!imagesDir.existsSync()) imagesDir.createSync(recursive: true);

      final newImagePath =
          '${imagesDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg}';

      setState(() {
        currentImage = pickedFile.path;
        _imageFile = newImagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/p (18).jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            textWidget("Ajouter un livre"),
            const SizedBox(height: 20),
            if (currentImage.isNotEmpty)
              Image.file(
                File(currentImage),
                height: 150,
                width: 150,
              ),
            FloatingActionButton(
              mini: true,
              onPressed: () {
                _pickPhoto(ImageSource.gallery);
              },
              heroTag: 'image0',
              tooltip: 'profil_author',
              child: const Icon(Icons.photo),
              backgroundColor: Colors.white,
            ),
            const Text(
              "Couverture du livre",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            textFieldWidget(authorController, "Nom de l'auteur", false),
            textFieldWidget(titleController, "Titre du livre", false),
            SelectFormField(
              labelText: 'Category',
              type: SelectFormFieldType.dropdown,
              controller: categoryController,
              items: BookModel.bookCategory,
            ),
            textFieldWidgetNumber(nbrpageController, "Nombre de page", false),
            textFieldWidget(isbnController, "ISBN", false),
            textareaWidget(resumeController, "Resumé", false),
            if (widget.isFinished)
              SizedBox(height: 50, child: star(stara))
            else
              SizedBox(
                  height: 100,
                  child: widget.isFinished ? star(stara) : priority()),
            ElevatedButton(
              onPressed: () async {
                final imageFile = File(currentImage);
                if (!File(_imageFile).existsSync() && currentImage != "") {
                  await imageFile.copy(_imageFile);
                }

                BookClass boky = BookClass(
                  title: titleController.text,
                  author: authorController.text,
                  version: 'vf',
                  note: stara.toString(),
                  resume: resumeController.text,
                  isFinished: widget.isFinished,
                  category: categoryController.text,
                  couverture: _imageFile,
                  isbn: isbnController.text,
                  nbrPage: nbrpageController.text,
                );
                if (widget.idBook == -1) {
                  _addBook(boky);
                } else {
                  _updateBook(widget.idBook, boky);
                }
                //message bien enregistrer
              },
              child: const Text(
                'Enregistrer',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 230, 116, 250)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _addBook(BookClass values) async {
    await BookModel.addBook(values);
    final idPage = (widget.isFinished) ? 0 : 2;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MyApp(index: idPage)),
      ),
    );
  }

  _updateBook(idBook, BookClass values) async {
    await BookModel.updateBook(idBook, values);
    final idPage = (widget.isFinished) ? 0 : 2;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MyApp(index: idPage)),
      ),
    );
  }

  Widget star(int nbr) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: ((context, index) {
          return IconButton(
            splashRadius: 1,
            constraints: const BoxConstraints(maxWidth: 30, minWidth: 20),
            onPressed: () {
              setState(() {
                stara = index + 1;
              });
            },
            iconSize: 30,
            icon: Icon((index < nbr) ? Icons.star : Icons.star_outline),
            color: (index < nbr)
                ? const Color.fromARGB(255, 236, 149, 252)
                : Colors.grey,
          );
        }));
  }

  Widget priority() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Priorité:',
          style: TextStyle(
              color: Color.fromARGB(255, 196, 192, 192), fontSize: 15),
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: priorityButton(
                  // ignore: prefer_const_constructors
                  5,
                  "Love troop",
                  const Color.fromARGB(255, 216, 3, 253))),
          Expanded(
              child: priorityButton(
                  4, "Love it", const Color.fromARGB(255, 233, 121, 253))),
          Expanded(
              child: priorityButton(
                  3, "like it", const Color.fromARGB(255, 172, 119, 182))),
        ])
      ],
    );
  }

  Widget priorityButton(star, String titre, color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          stara = star;
        });
      },
      child: Text(
        titre,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
    );
  }
}
