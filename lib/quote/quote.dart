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
  @override
  void initState() {
    super.initState();
    _filterdItems = _items;
  }

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
            onChanged: (q) {
              search(q);
            },
          ),
          Expanded(
            child: SizedBox(
              height: 3,
              child: _filterdItems.isEmpty
                  ? const Text('No quote, please insert')
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
              element.quote.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }
}
