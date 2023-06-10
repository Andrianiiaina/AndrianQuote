import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../models/BookModel.dart';
import 'style.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:date_field/date_field.dart';
import '../models/models.dart';
import 'package:flutter/services.dart';

class BookFormulaire extends StatefulWidget {
  final int idBook;
  const BookFormulaire({Key? key, this.idBook = -1}) : super(key: key);
  @override
  State<BookFormulaire> createState() => _BookFormulaireState();
}

class _BookFormulaireState extends State<BookFormulaire> {
  int stara = 0;
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController nbrpageController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String _imageFile = "";
  String currentImage = "";
  late BookClass book;
  final ImagePicker _picker = ImagePicker();
  late DateTime selectedDate;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.idBook != -1) {
      book = BookModel.getBook(widget.idBook);
      authorController.text = book.author;
      titleController.text = book.title;
      resumeController.text = book.resume;
      categoryController.text = book.category;
      versionController.text = book.version;
      nbrpageController.text = book.nbrPage.toString();
      try {
        stara = int.parse(book.note);
      } catch (e) {
        stara = 0;
      }
    }
    selectedDate = DateTime.now();
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
          child: Form(
            key: _formKey,
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
                  //initialValue: categoryController.text,
                  decoration: InputDecoration(
                    hintText: categoryController.text,
                    labelText: 'Category',
                  ),

                  type: SelectFormFieldType.dropdown,
                  controller: categoryController,
                  items: Models.bookCategory,
                ),

                SelectFormField(
                  decoration: InputDecoration(
                      hintText: versionController.text, labelText: 'Langage'),
                  type: SelectFormFieldType.dropdown,
                  controller: versionController,
                  items: Models.bookversion,
                ),
                textFieldWidgetNumber(
                    nbrpageController, "Nombre de page", false),
                textareaWidget(resumeController, "Resumé", false),
                DateTimeFormField(
                  decoration: InputDecoration(
                      hintText:
                          "Date: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"),
                  mode: DateTimeFieldPickerMode.date,
                  initialDate: selectedDate,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                ),
                TextFormField(
                  controller: noteController,
                  decoration: const InputDecoration(hintText: "Note[0-10]"),
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    var number = 0;
                    try {
                      number = int.parse(value!);
                    } catch (e) {}
                    if (number < 0 || number > 10) return "note sur 10";
                    return null;
                  },
                ),
                // SizedBox(height: 50, child: star(stara)),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final imageFile = File(currentImage);
                      if (!File(_imageFile).existsSync() &&
                          currentImage != "") {
                        await imageFile.copy(_imageFile);
                      }

                      BookClass boky = BookClass(
                        title: titleController.text,
                        author: authorController.text,
                        version: versionController.text,
                        note: noteController.text,
                        resume: resumeController.text,
                        category: categoryController.text,
                        couverture: _imageFile,
                        date: selectedDate,
                        nbrPage: nbrpageController.text,
                      );
                      if (widget.idBook == -1) {
                        _addBook(boky);
                      } else {
                        _updateBook(widget.idBook, boky);
                      }
                    }

                    //message bien enregistrer
                  },
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 116, 250)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15))),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }

  _addBook(BookClass values) async {
    await BookModel.addBook(values);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }

  _updateBook(idBook, BookClass values) async {
    await BookModel.updateBook(idBook, values);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }
}
