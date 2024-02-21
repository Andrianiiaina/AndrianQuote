import 'package:flutter/material.dart';
import 'quote_formulaire.dart';
import '../widgets/card_quote.dart';
import '../widgets/style.dart';
import '../models/quote_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

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

class ShowQuote extends StatefulWidget {
  final int idQuote;
  const ShowQuote({Key? key, required this.idQuote}) : super(key: key);

  @override
  State<ShowQuote> createState() => _ShowQuoteState();
}

class _ShowQuoteState extends State<ShowQuote> {
  late int idQuote;
  late QuotyClass? quote;
  @override
  void initState() {
    super.initState();
    idQuote = widget.idQuote;
    quote = QuoteModel.getQuote(idQuote);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableCarousel.builder(
      itemCount: _filterdItems.length,
      options: CarouselOptions(
        initialPage: idQuote,
        showIndicator: false,
        // autoPlay: true,
        //autoPlayInterval: const Duration(seconds: 2),
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final quote = _filterdItems[itemIndex];
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(quote.fond), fit: BoxFit.cover, opacity: 0.3),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  quote.quote,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(height: 15),
                Text(
                  "${quote.author} - ${quote.book}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
