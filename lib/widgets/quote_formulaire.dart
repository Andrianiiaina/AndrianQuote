import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../widgets/style.dart';
import '../widgets/book_formulaire.dart';
import '../main.dart';
import '../models/BookModel.dart';
import '../models/QuoteModel.dart';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QuoteFormulaire extends StatefulWidget {
  final int id;
  const QuoteFormulaire({Key? key, this.id = -1}) : super(key: key);

  @override
  State<QuoteFormulaire> createState() => _QuoteFormulaireState();
}

class _QuoteFormulaireState extends State<QuoteFormulaire> {
  final List<BookClass> _books = BookModel.getAllData();
  List<Map<String, dynamic>> bookField = [];
  late QuotyClass quote;
  final TextEditingController _book = TextEditingController();
  final TextEditingController _quoty = TextEditingController();
  String _imageFile = "";
  String currentImage = "";
  late BookClass book;
  final ImagePicker _picker = ImagePicker();

  _pickPhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/quotes');

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
  void initState() {
    super.initState();
    if (widget.id != -1) {
      quote = QuoteModel.getQuote(widget.id);
      _quoty.text = quote.quote;
      _book.text = "${quote.book}-${quote.author}";
    }

    _books.sort(((a, b) => b.date.compareTo(a.date)));
    for (int i = 0; i < _books.length; i++) {
      bookField.add({
        'value': "${_books[i].title}-${_books[i].author}",
        'label': "${_books[i].title} - ${_books[i].author}",
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: AssetImage('assets/p (10).jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(height: 30),
            textWidget("Nouveau quote"),
            const SizedBox(height: 15),
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
              "Fond du quote",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SelectFormField(
                    enableSearch: true,
                    hintText: "Book",
                    controller: _book,
                    type: SelectFormFieldType.dialog,
                    items: bookField,
                  ),
                ),

                //Ajouter d'autre Auteur

                IconButton(
                    onPressed: () {
                      showForm(
                        context,
                        const BookFormulaire(),
                      );
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(height: 10),
            textareaWidget(_quoty, 'Quote...', false),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final int x = Random().nextInt(36);
                final imageFile = File(currentImage);
                if (!File(_imageFile).existsSync() && currentImage != "") {
                  await imageFile.copy(_imageFile);
                }
                if (currentImage == "") _imageFile = "assets/p (${x + 1}).jpg";

                _createQuote(_book.text.split("-")[1], _book.text.split("-")[0],
                    _quoty.text, _imageFile);

                ///notif oe bien enregistrer
              },
              child: const Text(
                'Enregistrer le quote',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _createQuote(author, book, quote, fond) async {
    if (widget.id == -1) {
      await QuoteModel.addQuote(author, book, quote, fond);
    } else {
      await QuoteModel.updateQuote(widget.id, author, book, quote, fond);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 1)),
      ),
    );
  }
}
