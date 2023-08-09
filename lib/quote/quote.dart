import 'package:flutter/material.dart';
import '../widgets/quote_formulaire.dart';
import '../widgets/CardQuote.dart';
import '../widgets/style.dart';
import '../models/QuoteModel.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  final List<QuotyClass> _items = QuoteModel.getAllData();
  List<QuotyClass> _filterdItems = [];
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    _filterdItems = _items;
    _filterdItems.shuffle();
    isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotee'),
        actions: [
          if (isSearching == true)
            SizedBox(
              width: 180,
              child: TextField(
                decoration: const InputDecoration(hintText: "search..."),
                autofocus: true,
                onChanged: (q) {
                  search(q);
                },
              ),
            ),
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: 3,
              child: _filterdItems.isEmpty
                  ? Text(isSearching == true
                      ? "Aucun resultat."
                      : "Aucun quote disponible.")
                  : ListView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _filterdItems.length,
                      itemBuilder: ((context, index) {
                        final currentQuote = _filterdItems[index];
                        return cardQuote(currentQuote, context);
                      }),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
        onPressed: () {
          showForm(context, const QuoteFormulaire());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  search(String q) {
    setState(() {
      _filterdItems = _items
          .where((element) =>
              element.quote.toLowerCase().contains(q.toLowerCase()) ||
              element.author.toLowerCase().contains(q.toLowerCase()) ||
              element.book.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }
}
