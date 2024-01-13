import '../quote/show_quote.dart';
import 'package:flutter/material.dart';

Widget cardQuote(currentQuote, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: 160,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(currentQuote.fond),
          fit: BoxFit.cover,
          opacity: 0.6),
    ),
    padding: const EdgeInsets.only(top: 10),
    margin: const EdgeInsets.all(7),
    child: ListTile(
      textColor: Colors.white,
      title: Text(
        currentQuote.quote,
        textAlign: TextAlign.center,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${currentQuote.book} - ${currentQuote.author}",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ShowQuote(idQuote: currentQuote.id)),
          ),
        );
      },
    ),
  );
}
