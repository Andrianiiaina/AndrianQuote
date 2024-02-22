import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:select_form_field/select_form_field.dart';
import '../widgets/style.dart';
import '../book/book_formulaire.dart';
import '../models/book_model.dart';
import '../models/quote_model.dart';
import 'dart:math';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

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
  late BookClass book;
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
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
        height: MediaQuery.of(context).size.height + 100,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: AssetImage('assets/p (11).jpg'),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              textWidget("Nouveau quote"),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: SelectFormField(
                      enableSearch: true,
                      hintText: "Book",
                      controller: _book,
                      type: SelectFormFieldType.dialog,
                      items: bookField,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Veuillez selectionner un livre ou en créer un.";
                        return null;
                      },
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
                      icon: const Icon(
                        Icons.add,
                        color: Colors.deepPurple,
                      ))
                ],
              ),
              const SizedBox(height: 10),
              textareaWidgetForm(_quoty, 'Quote...', false),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);

                  String a = await getImageTotext(pickedFile!.path);

                  setState(() {
                    _quoty.text = a;
                  });
                },
                child: const Text(
                  "Quote à partir d'une image",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              //add personnalized backgroundcolor
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final int x = Random().nextInt(36);
                      if (widget.id == -1) {
                        await QuoteModel.addQuote(
                            _book.text.split("-")[1],
                            _book.text.split("-")[0],
                            _quoty.text,
                            "assets/p (${x + 1}).jpg");
                      } else {
                        await QuoteModel.updateQuote(
                            widget.id,
                            _book.text.split("-")[1],
                            _book.text.split("-")[0],
                            _quoty.text,
                            "assets/p (${x + 1}).jpg");
                      }
                      showMessage(context, "Opération réussie.");
                      Navigator.pop(context);
                      context.go('/quotes');
                    }

                    ///notif oe bien enregistrer
                  },
                  child: const Text(
                    'Enregistrer le quote',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future getImageTotext(final imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    String text = recognizedText.text.toString();
    return text;
  }
}
