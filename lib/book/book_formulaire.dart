import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book_model.dart';
import '../widgets/style.dart';
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

  TextEditingController authorController = TextEditingController(text: "");
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController categoryController = TextEditingController(text: "");
  TextEditingController versionController = TextEditingController(text: "");
  TextEditingController resumeController = TextEditingController(text: "");
  TextEditingController nbrpageController = TextEditingController(text: "");
  TextEditingController noteController = TextEditingController(text: "");
  TextEditingController statusController = TextEditingController(text: "");
  TextEditingController isPaperController = TextEditingController(text: "");

  String _imageFile = "";
  String currentImage = "";
  late BookClass book;
  final ImagePicker _picker = ImagePicker();
  late DateTime selectedDate;
  late DateTime selectedDebut;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedDebut = DateTime.now();
    if (widget.idBook != -1) {
      book = BookModel.getBook(widget.idBook);
      authorController.text = book.author;
      titleController.text = book.title;
      resumeController.text = book.resume;
      categoryController.text = book.category;
      versionController.text = book.version;
      nbrpageController.text = book.nbrPage.toString();
      selectedDate = book.date;
      selectedDebut = book.debut;
      isPaperController.text = book.isPaper.toString();
      noteController.text = book.note;
      statusController.text = book.status;
      isPaperController.text = book.isPaper ? 'paper' : 'numeric';
      try {
        stara = int.parse(book.note);
      } catch (e) {
        stara = 0;
      }
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
                  opacity: 0.6,
                  image: AssetImage('assets/p (11).jpg'),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                textWidget(widget.idBook == -1
                    ? "Ajouter un livre"
                    : "Modification du livre"),
                const SizedBox(height: 10),
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
                  backgroundColor: Colors.grey,
                ),
                const Text(
                  "(Couverture du livre si)",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                textFieldWidget(authorController, "Nom de l'auteur", false),
                textFieldWidget(titleController, "Titre du livre", false),
                selectFormWidget(
                    categoryController, "Catégorie", Models.bookCategory),
                selectFormWidget(
                    versionController, 'Langage', Models.bookversion),
                textFieldWidgetNumber(
                    nbrpageController, "Nombre de page", false),
                textareaWidgetForm(resumeController, "Resumé", false),
                DateTimeFormField(
                  dateTextStyle: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText:
                          "Debut: ${selectedDebut.year}-${selectedDebut.month}-${selectedDebut.day}"),
                  mode: DateTimeFieldPickerMode.date,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDebut = value;
                    });
                  },
                  initialDate: selectedDebut,
                ),
                DateTimeFormField(
                  dateTextStyle: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText:
                          "Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
                  mode: DateTimeFieldPickerMode.date,
                  initialDate: selectedDate,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: noteController,
                  decoration: const InputDecoration(label: Text("Note [0-10]")),
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    var number = 0;
                    try {
                      number = int.parse(value!);
                    } catch (e) {
                      number = 0;
                    }
                    if (number < 0 || number > 10) return "note sur 10";
                    return null;
                  },
                ),
                selectFormWidget(
                  statusController,
                  'Status',
                  [
                    {'value': 'finished', 'label': 'Terminé'},
                    {'value': 'abandonned', 'label': 'Abandonné'},
                    {'value': 'current', 'label': 'current'},
                  ],
                ),
                selectFormWidget(
                  isPaperController,
                  'Version',
                  [
                    {'value': 'paper', 'label': 'Papier'},
                    {'value': 'numeric', 'label': 'Numérique'},
                  ],
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!File(_imageFile).existsSync() &&
                            currentImage != "") {
                          await File(currentImage).copy(_imageFile);
                        }

                        BookClass newBook = BookClass(
                            title: titleController.text,
                            author: authorController.text,
                            version: versionController.text,
                            note: noteController.text,
                            resume: resumeController.text,
                            category: categoryController.text,
                            couverture: _imageFile,
                            date: selectedDate,
                            debut: selectedDebut,
                            nbrPage: int.parse(nbrpageController.text),
                            status: statusController.text,
                            isPaper: isPaperController.text == 'paper'
                                ? true
                                : false);
                        if (widget.idBook == -1) {
                          await BookModel.addBook(newBook);
                        } else {
                          await BookModel.updateBook(widget.idBook, newBook);
                        }
                        await StatisticModel.populateStatistic();
                        Navigator.pop(context);
                        context.go('/books');
                        showMessage(context, "Livre bien enregistré.");
                      }
                    },
                    child: const Text(
                      'Enregistrer',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
