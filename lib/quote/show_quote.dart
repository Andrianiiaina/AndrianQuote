import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../main.dart';
import '../widgets/style.dart';
import '../widgets/quote_formulaire.dart';

class ShowQuote extends StatefulWidget {
  final int idQuote;
  const ShowQuote({Key? key, required this.idQuote}) : super(key: key);

  @override
  State<ShowQuote> createState() => _ShowQuoteState();
}

class _ShowQuoteState extends State<ShowQuote> {
  late int idQuote;
  late QuotyClass? quote;

  ScrollController scrollC = ScrollController();
  bool showbtn = false;
  @override
  void initState() {
    super.initState();
    _initState();
    scrollC.addListener(() {
      double shoxoffset = 10.0;
      if (scrollC.offset > shoxoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
  }

  _initState() {
    idQuote = widget.idQuote;
    quote = QuoteModel.getQuote(idQuote);
  }

  _delete(int index) async {
    await QuoteModel.deleteQuote(index);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp(index: 1)),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(quote!.book),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showForm(context, QuoteFormulaire(id: widget.idQuote));
                });
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _delete(idQuote);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      floatingActionButton: AnimatedOpacity(
          opacity: showbtn ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: FloatingActionButton.small(
            backgroundColor: Colors.grey,
            onPressed: () {
              scrollC.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            },
            child: const Icon(
              Icons.arrow_upward,
            ),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollC,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(quote!.fond),
                fit: BoxFit.cover,
                opacity: 0.6),
          ),
          child: Column(
            children: [
              Text(
                "${quote!.author} - ${quote!.book}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                quote!.quote,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
