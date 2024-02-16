import 'package:flutter/material.dart';
import 'style.dart';
import 'package:go_router/go_router.dart';

class CardBook extends StatelessWidget {
  final book;
  const CardBook({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var note = 0;
    try {
      note = int.parse(book!.note);
    } catch (e) {
      note = 0;
    }
    return Container(
      color: Theme.of(context).colorScheme.background.withOpacity(0.05),
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
            context.go('/book/${book.id}');
          },
          trailing: SizedBox(
              width: MediaQuery.of(context).size.width / 4, child: star(note))),
    );
  }
}
