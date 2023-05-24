import 'package:flutter/material.dart';
import '../models/models.dart';
import '../author/show_author.dart';

//import '../authors/showAuthor.dart';
Widget cardAuthor(List<AuthorClass> authors) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: authors.length,
    itemBuilder: ((context, index) {
      AuthorClass author = authors[index];
      return SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/2.png'), fit: BoxFit.cover)),
          width: 80,
          margin: const EdgeInsets.all(3),
          child: Text(author.author),
        ),
      );
    }),
  );
}
/**
 * ListTile(
              leading: const Image(
                image: AssetImage('assets/2.png'),
                width: 70,
                fit: BoxFit.cover,
              ),
              title: Text(
                "${author.author} - ${author.id}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("${author.books.length} livres"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ShowAuthor(idAuthor: author.id)),
                  ),
                );
              },
            ),
 */