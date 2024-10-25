import 'package:flutter/material.dart';
import 'quote_formulaire.dart';
import '../widgets/card_quote.dart';
import '../widgets/widget.dart';
import '../models/quote_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

final List<QuotyClass> _items = QuoteModel.getAllData();
List<QuotyClass> _filterdItems = [];

class _QuotePageState extends State<QuotePage> {
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
      drawer: drawer,
      appBar: AppBar(
        title: const Text('Quotes'),
      ),
      body: Container(
          margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
          child: Column(
            children: [
              searchWidget(search),
              const SizedBox(height: 5),
              _filterdItems.isEmpty
                  ? Text(
                      isSearching == true ? "Aucun resultat." : "Aucun quote.")
                  : Expanded(
                      child: MasonryGridView.count(
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _filterdItems.length,
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          itemBuilder: (context, index) {
                            final currentQuote = _filterdItems[index];
                            return CardQuote(
                                currentQuote: currentQuote, index: index);
                          }),
                    ),
            ],
          )),
      floatingActionButton: FloatingActionButton.small(
        key: const Key("add_quote"),
        heroTag: 'h2',
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          showForm(context, const QuoteFormulaire());
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
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
