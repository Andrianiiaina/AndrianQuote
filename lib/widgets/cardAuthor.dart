import 'package:flutter/material.dart';
import '../author/show_author.dart';

//import '../authors/showAuthor.dart';
Widget cardAuthor(author, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => ShowAuthor(idAuthor: author.id)),
        ),
      );
    },
    child: SizedBox(
      height: 70,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/p (2).png'), fit: BoxFit.cover)),
        width: 80,
        margin: const EdgeInsets.all(3),
        // child: Text(author.author),
        child: Text(author.profile),
      ),
    ),
  );
}
/**
 * Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/2.png'), fit: BoxFit.cover)),
        width: 80,
        margin: const EdgeInsets.all(3),
        child: Text(author.author),
      ),
 */