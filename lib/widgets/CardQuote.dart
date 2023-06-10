import '/quote/showQuote.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Widget cardQuote(currentQuote, BuildContext context) {
  final int x = Random().nextInt(36);
  return Container(
    alignment: Alignment.center,
    height: 160,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/p (${x + 1}).jpg'),
          fit: BoxFit.cover,
          opacity: 0.6),
    ),
    padding: const EdgeInsets.only(top: 10),
    margin: const EdgeInsets.all(7),
    child: ListTile(
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
            builder: ((context) =>
                ShowQuote(idQuote: currentQuote.id, idFond: x)),
          ),
        );
      },
    ),
  );
}
