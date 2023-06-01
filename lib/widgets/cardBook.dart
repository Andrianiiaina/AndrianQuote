import 'package:flutter/material.dart';
import '../book/show_book.dart';

star(int nbr) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: ((context, index) {
        return Icon(
          (index < nbr) ? Icons.star : Icons.star_outline,
          size: 15,
          color:
              (index < nbr) ? Color.fromARGB(255, 236, 149, 252) : Colors.grey,
        );
      }));
}

Widget cardBook(book, context) {
  return Container(
    key: ValueKey(book.id),
    color: const Color.fromARGB(255, 71, 70, 70),
    margin: const EdgeInsets.all(3),
    child: ListTile(
        title: Text(book.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(book.author),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ShowBook(idBook: book.id)),
            ),
          );
        },
        trailing: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: star(int.parse(book.note)))),
  );
}
