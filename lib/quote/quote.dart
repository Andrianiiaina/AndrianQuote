import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
//import 'searchQuote.dart';
import '../models/models.dart';
import '../widgets/quote_formulaire.dart';
import '../widgets/CardQuote.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  final _quoteBox = Hive.box<QuoteClass>('quoty');
  List<QuoteClass> _items = [];

  void _refreshItems() {
    final data = _quoteBox.keys.map((e) {
      final value = _quoteBox.get(e);
      return QuoteClass(
          id: e, author: value!.author, book: value.book, quote: value.quote);
    }).toList();
    setState(() {
      _items = data.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  _showFormulaire(BuildContext context) async {
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
              child: const QuoteFormulaire(),
            ));
  }

/**  _search(String q) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((_) => SearchQuote(q: q)),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Andrianiiaina Quotes'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.search), hintText: "rechercher un quote"),
            onSubmitted: (q) {
              // _search(q);
            },
          ),
          Expanded(
            child: SizedBox(
              height: 5,
              child: Expanded(
                flex: 7,
                child: _items.isEmpty
                    ? const Text('No quote, please insert')
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: ((context, index) {
                          final currentQuote = _items[index];
                          return cardQuote(currentQuote, context);
                        }),
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
        onPressed: () {
          _showFormulaire(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
