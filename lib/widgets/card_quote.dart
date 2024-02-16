import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:go_router/go_router.dart';
import 'quote_formulaire.dart';
import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class CardQuote extends StatelessWidget {
  final QuotyClass currentQuote;
  final int index;
  const CardQuote({Key? key, required this.currentQuote, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _delete(int index) async {
      QuoteModel.deleteQuote(index);
      showMessage(context, "Le quote a bien été supprimé.");
      context.go('/quotes');
    }

    return Container(
      alignment: Alignment.center,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(currentQuote.fond),
            fit: BoxFit.cover,
            opacity: 0.6),
      ),
      //padding: const EdgeInsets.only(top: 10),
      margin: index == 1
          ? const EdgeInsets.fromLTRB(2, 25, 2, 2)
          : const EdgeInsets.fromLTRB(2, 5, 2, 2), //EdgeInsets.all(2),
      child: ListTile(
        textColor: Colors.white,
        title: Text(
          currentQuote.quote,
          textAlign: TextAlign.center,
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${currentQuote.book} - ${currentQuote.author}",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
        onTap: () {
          context.go('/quote/${index}');
        },
        onLongPress: () {
          showForm(
            context,
            Card(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        showForm(context, QuoteFormulaire(id: currentQuote.id));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        ShowConfirmation(context, "Confirmation",
                            "Etes-vous sur de vouloir supprimer ce livre?", () {
                          _delete(currentQuote.id);
                        });
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
