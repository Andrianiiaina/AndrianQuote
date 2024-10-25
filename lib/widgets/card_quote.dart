import 'package:andrianiaiina_quote/widgets/widget.dart';
import 'package:go_router/go_router.dart';
import '../quote/quote_formulaire.dart';
import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class CardQuote extends StatelessWidget {
  final QuotyClass currentQuote;
  final int index;
  const CardQuote({Key? key, required this.currentQuote, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: index / 2 == 0 ? 220 : 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(currentQuote.fond),
            fit: BoxFit.cover,
            opacity: 0.6),
      ),
      margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
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
            context.go('/quote/$index');
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Opération"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        showForm(context, QuoteFormulaire(id: currentQuote.id));
                      },
                      child: const Text('Modifier'),
                    ),
                    TextButton(
                      onPressed: () {
                        showConfirmation(context, "Confirmation",
                            "Etes-vous sur de vouloir supprimer ce livre?", () {
                          QuoteModel.deleteQuote(currentQuote.id);
                          showMessage(context, "Le quote a bien été supprimé.");
                          context.go('/quotes');
                          context.pop();
                        });
                      },
                      child: const Text('Supprimer'),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
