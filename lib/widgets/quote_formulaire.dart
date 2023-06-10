import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../widgets/style.dart';
import '../widgets/book_formulaire.dart';
import '../main.dart';
import '../models/BookModel.dart';
import '../models/QuoteModel.dart';

class QuoteFormulaire extends StatefulWidget {
  const QuoteFormulaire({Key? key}) : super(key: key);

  @override
  State<QuoteFormulaire> createState() => _QuoteFormulaireState();
}

class _QuoteFormulaireState extends State<QuoteFormulaire> {
  final List<BookClass> _books = BookModel.getAllData();
  List<Map<String, dynamic>> bookField = [];

  @override
  void initState() {
    super.initState();
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
    TextEditingController _book = TextEditingController();
    TextEditingController _quoty = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: AssetImage('assets/p (10).jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(height: 50),
            textWidget("Ajouter un quote"),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            textareaWidget(_quoty, 'Quote...', false),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                List<String> book = _book.text.split("-");
                _createQuote(book[1], book[0], _quoty.text);

                ///notif oe bien enregistrer
              },
              child: const Text(
                'Enregistrer le quote',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createQuote(author, book, quote) async {
    await QuoteModel.addQuote(author, book, quote);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 1)),
      ),
    );
  }
}
