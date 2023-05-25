import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../models/models.dart';
import 'package:hive/hive.dart';
import '../widgets/style.dart';
import '../widgets/book_formulaire.dart';
import '../main.dart';

class QuoteFormulaire extends StatefulWidget {
  const QuoteFormulaire({Key? key}) : super(key: key);

  @override
  State<QuoteFormulaire> createState() => _QuoteFormulaireState();
}

class _QuoteFormulaireState extends State<QuoteFormulaire> {
  final _bookBox = Hive.box<BookClass>('book');
  final _quoteBox = Hive.box<QuoteClass>('quoty');

  List<BookClass> _books = [];
  List<Map<String, dynamic>> bookField = [];

  @override
  void initState() {
    super.initState();
    _refreshItem();
  }

  _refreshItem() {
    final dataa = _bookBox.keys.map((e) {
      final value = _bookBox.get(e);
      return value!;
    });
    _books = dataa.toList();
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
    return Column(
      children: [
        textWidget("Ajouter un quote"),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SelectFormField(
                hintText: "Auteur - Titre",
                controller: _book,
                type: SelectFormFieldType.dropdown,
                items: bookField,
              ),
            ),
            //Ajouter d'autre Auteur
            IconButton(
                onPressed: () {
                  showNewBookForm(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        const SizedBox(height: 30),
        textFieldWidget(_quoty, 'Quote...'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            List<String> book = _book.text.split("-");
            _createQuote(
                QuoteClass(author: book[1], book: book[0], quote: _quoty.text));
            // Navigator.push(context,
            //   MaterialPageRoute(builder: (_) => ShowQuote(idQuote: boky.id)));
            //notif oe bien enregistrer
          },
          child: const Text('Enregistrer le quote'),
        ),
      ],
    );
  }

  Future<void> _createQuote(QuoteClass newQuote) async {
    await _quoteBox.add(newQuote);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 1)),
      ),
    );
    // await _quoteBox.put('key', newQuote);
    // _refreshItems();
  }

  Future showNewBookForm(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 5,
      builder: (_) => Container(
        padding: EdgeInsets.only(
            left: 10,
            top: 2,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const BookFormulaire(
          isFinished: true,
        ),
      ),
    );
  }
}
