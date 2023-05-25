import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:hive/hive.dart';
import '../main.dart';

class ShowQuote extends StatefulWidget {
  final int idQuote;
  const ShowQuote({Key? key, required this.idQuote}) : super(key: key);

  @override
  State<ShowQuote> createState() => _ShowQuoteState();
}

class _ShowQuoteState extends State<ShowQuote> {
  late int idQuote;
  late QuoteClass? quote;
  late bool isReadOnly;
  final box = Hive.box<QuoteClass>('quoty');

  @override
  void initState() {
    super.initState();
    _initState();
  }

  _initState() {
    idQuote = widget.idQuote;
    quote = box.get(idQuote);
    isReadOnly = true;
  }

  _update(String quoteE) async {
    await box.put(idQuote,
        QuoteClass(author: quote!.author, book: quote!.book, quote: quoteE));
    _initState();
    setState(() {
      isReadOnly = true;
    });
  }

  _delete(int index) async {
    await box.delete(index);
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
          title: Text('${quote?.author} - ${quote?.book}'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isReadOnly = false;
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
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Text("${quote!.author} - ${quote!.author}"),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: "Quote:"),
                controller: _quote,
                readOnly: isReadOnly,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                minLines: 2,
              ),
              const SizedBox(height: 10),
              if (isReadOnly == false)
                ElevatedButton(
                    onPressed: () {
                      _update(_quote.text);
                    },
                    child: const Text('Enregistrer les modifications')),
            ],
          ),
        ));
  }
}
