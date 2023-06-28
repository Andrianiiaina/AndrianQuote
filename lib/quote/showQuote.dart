import 'package:flutter/material.dart';
import '../models/QuoteModel.dart';
import '../main.dart';
import '../widgets/style.dart';
import '../widgets/quote_formulaire.dart';

class ShowQuote extends StatefulWidget {
  final int idQuote;
  final int idFond;
  const ShowQuote({Key? key, required this.idQuote, required this.idFond})
      : super(key: key);

  @override
  State<ShowQuote> createState() => _ShowQuoteState();
}

class _ShowQuoteState extends State<ShowQuote> {
  late int idQuote;
  late QuotyClass? quote;

  @override
  void initState() {
    super.initState();
    _initState();
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
    TextEditingController _quote = TextEditingController(text: quote?.quote);
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
          title: const Text("Quotee details"),
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
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/p (${widget.idFond + 1}).jpg'),
                fit: BoxFit.cover,
                opacity: 0.6),
          ),
          child: Column(
            children: [
              Text(
                "${quote!.author} - ${quote!.book}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              //textareaWidget(_quote, "Quote...", isReadOnly),
              Text(quote!.quote),
              const SizedBox(height: 10),
            ],
          ),
        )));
  }
}
