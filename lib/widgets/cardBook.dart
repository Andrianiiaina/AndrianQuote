import 'package:flutter/material.dart';
import '../book/show_book.dart';
import 'style.dart';

Widget cardBook(book, context) {
  return Container(
    key: ValueKey(book.id),
    color: const Color.fromARGB(255, 71, 70, 70),
    margin: const EdgeInsets.all(3),
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
            width: MediaQuery.of(context).size.width / 4,
            child: star(int.parse(book.note)))),
  );
}
