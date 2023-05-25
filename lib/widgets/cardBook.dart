import 'package:flutter/material.dart';
import '../models/models.dart';
import '../book/show_book.dart';

//import '../books/showAuthor.dart';
Widget cardBook(List<BookClass> books) {
  return ListView.builder(
      //scrollDirection: Axis.horizontal,
      itemCount: books.length,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        BookClass book = books[index];
        return Container(
            color: const Color.fromARGB(255, 71, 70, 70),
            margin: const EdgeInsets.all(3),
            child: ListTile(
              title: Text(
                book.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(book.author),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ShowBook(idBook: book.id)),
                  ),
                );
              },
              trailing: Text(book.note),
            ));
      }));
}
