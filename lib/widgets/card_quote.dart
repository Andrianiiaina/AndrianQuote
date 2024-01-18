import '../quote/show_quote.dart';
import 'package:flutter/material.dart';

Widget cardQuote(index, currentQuote, BuildContext context) {
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
        ? EdgeInsets.fromLTRB(2, 25, 2, 2)
        : EdgeInsets.fromLTRB(2, 5, 2, 2), //EdgeInsets.all(2),
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
