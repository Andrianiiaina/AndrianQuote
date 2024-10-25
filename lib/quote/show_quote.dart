import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ShowQuote extends StatefulWidget {
  final int idQuote;
  const ShowQuote({Key? key, required this.idQuote}) : super(key: key);

  @override
  State<ShowQuote> createState() => _ShowQuoteState();
}

final List<QuotyClass> _items = QuoteModel.getAllData();
List<QuotyClass> _filterdItems = [];

class _ShowQuoteState extends State<ShowQuote> {
  late int idQuote;
  late QuotyClass? quote;

  @override
  void initState() {
    super.initState();
    idQuote = widget.idQuote;
    _filterdItems = _items;
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
