import 'package:flutter/material.dart';
import '../book/show_book.dart';
import 'style.dart';

Widget cardBook(book, context) {
  var note = 0;
  try {
    note = int.parse(book!.note);
  } catch (e) {
    note = 0;
  }
  return Container(
    color: Theme.of(context).backgroundColor.withOpacity(0.05),
    key: ValueKey(book.id),
    margin: const EdgeInsets.all(2),
    child: ListTile(
        title: Text(book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(book.author),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ShowBook(
                    idBook: book.id,
                    isFinished: true,
                  )),
            ),
          );
        },
        trailing: SizedBox(
            width: MediaQuery.of(context).size.width / 4, child: star(note))),
  );
}
